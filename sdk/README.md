# AllScreenshots SDK for Swift

A Swift SDK for the [AllScreenshots](https://allscreenshots.com) API, providing programmatic screenshot capture capabilities.

## Features

- Synchronous and asynchronous screenshot capture
- Bulk screenshot operations
- Screenshot composition with multiple layouts
- Scheduled screenshots with cron expressions
- Usage and quota tracking
- Automatic retry with exponential backoff
- Full Swift concurrency support (async/await)
- Type-safe API with Codable models

## Requirements

- Swift 5.9+
- macOS 12+ / iOS 15+ / tvOS 15+ / watchOS 8+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/allscreenshots/allscreenshots-sdk-swift.git", from: "1.0.0")
]
```

Then add the dependency to your target:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["AllScreenshotsSDK"]
    )
]
```

### Xcode

1. Open your project in Xcode
2. Go to File > Add Package Dependencies
3. Enter the repository URL: `https://github.com/allscreenshots/allscreenshots-sdk-swift.git`
4. Select the version and add to your project

## Quick start

```swift
import AllScreenshotsSDK

// Create a client (reads API key from ALLSCREENSHOTS_API_KEY environment variable)
let client = try AllScreenshotsClient()

// Take a screenshot
let request = ScreenshotRequest(
    url: "https://example.com",
    device: "Desktop HD"
)
let imageData = try await client.takeScreenshot(request)

// Save the image
try imageData.write(to: URL(fileURLWithPath: "screenshot.png"))
```

## Configuration

### Using environment variable (recommended)

Set the `ALLSCREENSHOTS_API_KEY` environment variable:

```bash
export ALLSCREENSHOTS_API_KEY=your-api-key
```

Then create the client without parameters:

```swift
let client = try AllScreenshotsClient()
```

### Explicit API key

```swift
let client = try AllScreenshotsClient(apiKey: "your-api-key")
```

### Builder pattern

```swift
let client = try AllScreenshotsClient.builder { builder in
    builder
        .apiKey("your-api-key")
        .timeout(120)  // 2 minutes
        .noRetry()     // Disable automatic retries
}
```

### Full configuration

```swift
let config = try AllScreenshotsClientConfiguration(
    apiKey: "your-api-key",
    baseURL: URL(string: "https://api.allscreenshots.com")!,
    timeout: 60,
    retryPolicy: RetryPolicy(
        maxRetries: 5,
        baseDelay: 1.0,
        maxDelay: 60.0,
        multiplier: 2.0,
        retryableStatusCodes: [429, 500, 502, 503, 504]
    ),
    userAgent: "MyApp/1.0"
)
let client = AllScreenshotsClient(configuration: config)
```

## API reference

### Screenshots

#### Take a screenshot (synchronous)

```swift
let request = ScreenshotRequest(
    url: "https://github.com",
    device: "Desktop HD",
    format: .png,
    fullPage: true,
    quality: 90,
    darkMode: true
)
let imageData = try await client.takeScreenshot(request)
```

#### Take a screenshot (asynchronous)

```swift
let request = ScreenshotRequest(url: "https://github.com")
let job = try await client.takeScreenshotAsync(request)

// Poll for completion
while true {
    let status = try await client.getJob(job.id)
    if status.status == .completed {
        let imageData = try await client.getJobResult(job.id)
        break
    } else if status.status == .failed {
        throw AllScreenshotsError.serverError(statusCode: 500, message: status.errorMessage)
    }
    try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
}
```

#### Screenshot request options

| Parameter | Type | Description |
|-----------|------|-------------|
| `url` | String | Target URL (required) |
| `device` | String | Device preset (e.g., "Desktop HD", "iPhone 14", "iPad") |
| `viewport` | ViewportConfig | Custom viewport dimensions |
| `format` | ImageFormat | Output format: `.png`, `.jpeg`, `.webp`, `.pdf` |
| `fullPage` | Bool | Capture entire scrollable page |
| `quality` | Int | JPEG/WebP quality (1-100) |
| `delay` | Int | Delay before capture in milliseconds |
| `waitFor` | String | CSS selector to wait for |
| `waitUntil` | WaitUntil | Wait condition: `.load`, `.domcontentloaded`, `.networkidle` |
| `timeout` | Int | Timeout in milliseconds |
| `darkMode` | Bool | Enable dark mode |
| `customCss` | String | Custom CSS to inject |
| `hideSelectors` | [String] | CSS selectors to hide |
| `selector` | String | Capture specific element |
| `blockAds` | Bool | Block advertisements |
| `blockCookieBanners` | Bool | Block cookie consent banners |
| `blockLevel` | BlockLevel | Content blocking level |

### Bulk screenshots

```swift
let request = BulkRequest(
    urls: [
        BulkUrlRequest(url: "https://example1.com"),
        BulkUrlRequest(url: "https://example2.com", options: BulkUrlOptions(device: "iPhone 14")),
        BulkUrlRequest(url: "https://example3.com")
    ],
    defaults: BulkDefaults(device: "Desktop HD", format: .png)
)

let bulkJob = try await client.createBulkJob(request)

// Monitor progress
while true {
    let status = try await client.getBulkJob(bulkJob.id)
    print("Progress: \(status.progress)%")
    if status.status == "COMPLETED" {
        break
    }
    try await Task.sleep(nanoseconds: 2_000_000_000)
}
```

### Screenshot composition

Compose multiple screenshots into a single image:

```swift
let request = ComposeRequest(
    captures: [
        CaptureItem(url: "https://example.com", device: "Desktop HD", label: "Desktop"),
        CaptureItem(url: "https://example.com", device: "iPhone 14", label: "Mobile"),
        CaptureItem(url: "https://example.com", device: "iPad", label: "Tablet")
    ],
    output: ComposeOutputConfig(
        layout: .grid,
        columns: 3,
        spacing: 20,
        background: "#ffffff"
    )
)

let result = try await client.compose(request)
print("Composed image URL: \(result.result?.url ?? "")")
```

### Scheduled screenshots

```swift
// Create a schedule
let schedule = try await client.createSchedule(CreateScheduleRequest(
    name: "Daily Homepage",
    url: "https://example.com",
    schedule: "0 9 * * *",  // Every day at 9 AM
    timezone: "America/New_York",
    options: ScheduleScreenshotOptions(device: "Desktop HD", fullPage: true),
    retentionDays: 30
))

// List schedules
let schedules = try await client.listSchedules()

// Get history
let history = try await client.getScheduleHistory(schedule.id, limit: 10)

// Pause/resume
try await client.pauseSchedule(schedule.id)
try await client.resumeSchedule(schedule.id)

// Manually trigger
try await client.triggerSchedule(schedule.id)

// Delete
try await client.deleteSchedule(schedule.id)
```

### Usage and quota

```swift
// Get current usage
let usage = try await client.getUsage()
print("Screenshots this period: \(usage.currentPeriod.screenshotsCount)")

// Check quota
let quota = try await client.getQuotaStatus()
print("Remaining: \(quota.screenshots.remaining) of \(quota.screenshots.limit)")
```

## Error handling

The SDK uses typed errors for clear error handling:

```swift
do {
    let imageData = try await client.takeScreenshot(request)
} catch AllScreenshotsError.missingApiKey {
    print("API key not configured")
} catch AllScreenshotsError.unauthorized(let message) {
    print("Authentication failed: \(message ?? "Invalid API key")")
} catch AllScreenshotsError.validationError(let message, let details) {
    print("Validation error: \(message)")
    details?.forEach { print("  \($0.key): \($0.value)") }
} catch AllScreenshotsError.rateLimitExceeded(let retryAfter) {
    if let retryAfter = retryAfter {
        print("Rate limited. Retry after \(retryAfter) seconds")
    }
} catch AllScreenshotsError.serverError(let statusCode, let message) {
    print("Server error \(statusCode): \(message ?? "")")
} catch {
    print("Unexpected error: \(error)")
}
```

### Error types

| Error | Description |
|-------|-------------|
| `missingApiKey` | API key not provided |
| `invalidURL` | Invalid URL format |
| `invalidRequest` | Request validation failed |
| `networkError` | Network connectivity issue |
| `serverError` | Server returned error response |
| `rateLimitExceeded` | Rate limit exceeded |
| `unauthorized` | Authentication failed |
| `notFound` | Resource not found |
| `validationError` | Request validation failed |
| `timeout` | Request timed out |
| `decodingError` | Failed to decode response |
| `encodingError` | Failed to encode request |

## Retry policy

The SDK automatically retries failed requests with exponential backoff. Default policy:

- Maximum retries: 3
- Base delay: 1 second
- Maximum delay: 30 seconds
- Multiplier: 2x
- Retryable status codes: 408, 429, 500, 502, 503, 504

Customize the retry policy:

```swift
let config = try AllScreenshotsClientConfiguration(
    apiKey: "your-key",
    retryPolicy: RetryPolicy(
        maxRetries: 5,
        baseDelay: 2.0,
        maxDelay: 60.0,
        multiplier: 2.0,
        retryableStatusCodes: [429, 500, 502, 503, 504]
    )
)
```

Or disable retries:

```swift
let client = try AllScreenshotsClient.builder { $0.noRetry() }
```

## Testing

Run unit tests:

```bash
swift test --filter AllScreenshotsSDKTests
```

Run integration tests (requires API key):

```bash
export ALLSCREENSHOTS_API_KEY=your-api-key
swift test --filter IntegrationTests
```

## License

Apache License 2.0. See [LICENSE](LICENSE) for details.
