import SwiftUI
import AllScreenshotsSDK

struct ContentView: View {
    @StateObject private var viewModel = ScreenshotViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HeaderView()

            Divider()

            // Controls
            ControlsView(viewModel: viewModel)

            Divider()

            // Result area
            ResultView(viewModel: viewModel)
        }
        .frame(minWidth: 800, minHeight: 600)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

// MARK: - Header

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Allscreenshots Demo")
                .font(.title2)
                .fontWeight(.semibold)

            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(Color(NSColor.controlBackgroundColor))
    }
}

// MARK: - Controls

struct ControlsView: View {
    @ObservedObject var viewModel: ScreenshotViewModel

    private let devices = ["Desktop HD", "iPhone 14", "iPad"]

    var body: some View {
        VStack(spacing: 16) {
            // URL input and button row
            HStack(spacing: 12) {
                TextField("Enter URL", text: $viewModel.url)
                    .textFieldStyle(.roundedBorder)
                    .font(.body)

                Button(action: viewModel.takeScreenshot) {
                    HStack(spacing: 6) {
                        if viewModel.isLoading {
                            ProgressView()
                                .scaleEffect(0.7)
                                .frame(width: 16, height: 16)
                        }
                        Text("Take Screenshot")
                    }
                    .frame(width: 140)
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading || viewModel.url.isEmpty)
            }

            // Options row
            HStack(spacing: 24) {
                // Device picker
                HStack(spacing: 8) {
                    Text("Device")
                        .foregroundColor(.secondary)
                    Picker("", selection: $viewModel.selectedDevice) {
                        ForEach(devices, id: \.self) { device in
                            Text(device).tag(device)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 140)
                }

                // Full page toggle
                Toggle("Full page", isOn: $viewModel.fullPage)
                    .toggleStyle(.checkbox)

                Spacer()
            }
        }
        .padding(24)
        .background(Color(NSColor.controlBackgroundColor))
    }
}

// MARK: - Result View

struct ResultView: View {
    @ObservedObject var viewModel: ScreenshotViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Result")
                .font(.headline)
                .foregroundColor(.secondary)

            if let error = viewModel.errorMessage {
                ErrorBanner(message: error)
            }

            if viewModel.isLoading {
                LoadingView()
            } else if let image = viewModel.screenshotImage {
                ScreenshotImageView(image: image)
            } else {
                EmptyStateView()
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

// MARK: - Supporting Views

struct ErrorBanner: View {
    let message: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
            Text(message)
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(12)
        .background(Color.red.opacity(0.1))
        .cornerRadius(8)
    }
}

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Capturing screenshot...")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ScreenshotImageView: View {
    let image: NSImage

    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            Image(nsImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(NSColor.textBackgroundColor))
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "photo")
                .font(.system(size: 48))
                .foregroundColor(.secondary.opacity(0.5))
            Text("Screenshot will appear here")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
