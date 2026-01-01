import Foundation

/// Errors that can occur when using the AllScreenshots SDK
public enum AllScreenshotsError: Error, LocalizedError, Sendable {
    /// API key is missing or invalid
    case missingApiKey
    /// Invalid URL provided
    case invalidURL(String)
    /// Invalid request parameters
    case invalidRequest(String)
    /// Network error occurred
    case networkError(Error)
    /// Server returned an error response
    case serverError(statusCode: Int, message: String?)
    /// Rate limit exceeded
    case rateLimitExceeded(retryAfter: TimeInterval?)
    /// Authentication failed
    case unauthorized(message: String?)
    /// Resource not found
    case notFound(message: String?)
    /// Request validation failed
    case validationError(message: String, details: [String: String]?)
    /// Timeout waiting for response
    case timeout
    /// Failed to decode response
    case decodingError(Error)
    /// Failed to encode request
    case encodingError(Error)
    /// Unknown error
    case unknown(String)

    public var errorDescription: String? {
        switch self {
        case .missingApiKey:
            return "API key is required. Set ALLSCREENSHOTS_API_KEY environment variable or provide it in the client configuration."
        case .invalidURL(let url):
            return "Invalid URL: \(url)"
        case .invalidRequest(let message):
            return "Invalid request: \(message)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .serverError(let statusCode, let message):
            if let message = message {
                return "Server error (\(statusCode)): \(message)"
            }
            return "Server error with status code \(statusCode)"
        case .rateLimitExceeded(let retryAfter):
            if let retryAfter = retryAfter {
                return "Rate limit exceeded. Retry after \(Int(retryAfter)) seconds."
            }
            return "Rate limit exceeded."
        case .unauthorized(let message):
            if let message = message {
                return "Unauthorized: \(message)"
            }
            return "Unauthorized. Check your API key."
        case .notFound(let message):
            if let message = message {
                return "Not found: \(message)"
            }
            return "Resource not found."
        case .validationError(let message, let details):
            if let details = details, !details.isEmpty {
                let detailsStr = details.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
                return "Validation error: \(message) (\(detailsStr))"
            }
            return "Validation error: \(message)"
        case .timeout:
            return "Request timed out."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .encodingError(let error):
            return "Failed to encode request: \(error.localizedDescription)"
        case .unknown(let message):
            return "Unknown error: \(message)"
        }
    }

    /// HTTP status code associated with the error, if applicable
    public var statusCode: Int? {
        switch self {
        case .serverError(let code, _):
            return code
        case .rateLimitExceeded:
            return 429
        case .unauthorized:
            return 401
        case .notFound:
            return 404
        case .validationError:
            return 400
        default:
            return nil
        }
    }

    /// Whether the error is retryable
    public var isRetryable: Bool {
        switch self {
        case .rateLimitExceeded, .timeout, .networkError:
            return true
        case .serverError(let statusCode, _):
            return [500, 502, 503, 504].contains(statusCode)
        default:
            return false
        }
    }
}

/// Error response from the API
public struct ErrorResponse: Codable, Sendable {
    public let error: String?
    public let message: String?
    public let code: String?
    public let details: [String: String]?
}
