/// AllScreenshots SDK for Swift
///
/// A Swift SDK for the AllScreenshots API, providing screenshot capture capabilities.
///
/// ## Quick Start
///
/// ```swift
/// import AllScreenshotsSDK
///
/// // Create a client (reads API key from ALLSCREENSHOTS_API_KEY environment variable)
/// let client = try AllScreenshotsClient()
///
/// // Take a screenshot
/// let request = ScreenshotRequest(url: "https://example.com", device: "Desktop HD")
/// let imageData = try await client.takeScreenshot(request)
/// ```
///
/// ## Features
///
/// - Synchronous and asynchronous screenshot capture
/// - Bulk screenshot operations
/// - Screenshot composition with multiple layouts
/// - Scheduled screenshots
/// - Usage and quota tracking
/// - Automatic retry with exponential backoff
/// - Full Swift concurrency support

// Re-export all public types
@_exported import Foundation

// MARK: - Version

/// SDK version
public let allScreenshotsSDKVersion = "1.0.0"
