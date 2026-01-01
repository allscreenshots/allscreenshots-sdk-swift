import SwiftUI
import AllScreenshotsSDK

@MainActor
class ScreenshotViewModel: ObservableObject {
    @Published var url: String = "https://github.com"
    @Published var selectedDevice: String = "Desktop HD"
    @Published var fullPage: Bool = false
    @Published var isLoading: Bool = false
    @Published var screenshotImage: NSImage?
    @Published var errorMessage: String?

    private var client: AllScreenshotsClient?

    init() {
        setupClient()
    }

    private func setupClient() {
        do {
            client = try AllScreenshotsClient()
        } catch {
            errorMessage = "Failed to initialize client: \(error.localizedDescription)"
        }
    }

    func takeScreenshot() {
        guard let client = client else {
            errorMessage = "Client not initialized. Check your API key."
            return
        }

        guard !url.isEmpty else {
            errorMessage = "Please enter a URL"
            return
        }

        // Clear previous state
        errorMessage = nil
        screenshotImage = nil
        isLoading = true

        Task {
            do {
                let request = ScreenshotRequest(
                    url: url,
                    device: selectedDevice,
                    fullPage: fullPage
                )

                let imageData = try await client.takeScreenshot(request)

                guard let image = NSImage(data: imageData) else {
                    throw AllScreenshotsError.unknown("Failed to create image from data")
                }

                await MainActor.run {
                    self.screenshotImage = image
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.handleError(error)
                    self.isLoading = false
                }
            }
        }
    }

    private func handleError(_ error: Error) {
        if let screenshotError = error as? AllScreenshotsError {
            switch screenshotError {
            case .missingApiKey:
                errorMessage = "API key not configured. Set the ALLSCREENSHOTS_API_KEY environment variable."
            case .invalidURL(let url):
                errorMessage = "Invalid URL: \(url)"
            case .unauthorized(let message):
                errorMessage = "Authentication failed: \(message ?? "Invalid API key")"
            case .validationError(let message, _):
                errorMessage = "Validation error: \(message)"
            case .rateLimitExceeded(let retryAfter):
                if let retryAfter = retryAfter {
                    errorMessage = "Rate limit exceeded. Please wait \(Int(retryAfter)) seconds."
                } else {
                    errorMessage = "Rate limit exceeded. Please try again later."
                }
            case .serverError(let statusCode, let message):
                errorMessage = "Server error (\(statusCode)): \(message ?? "Unknown error")"
            case .timeout:
                errorMessage = "Request timed out. Please try again."
            case .networkError(let underlyingError):
                errorMessage = "Network error: \(underlyingError.localizedDescription)"
            default:
                errorMessage = screenshotError.localizedDescription
            }
        } else {
            errorMessage = error.localizedDescription
        }
    }
}
