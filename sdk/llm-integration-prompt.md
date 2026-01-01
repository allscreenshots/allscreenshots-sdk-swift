# AllScreenshots Swift SDK - LLM integration prompt

Use this prompt to help LLMs understand and use the AllScreenshots Swift SDK.

---

## SDK overview

The AllScreenshots Swift SDK provides programmatic screenshot capture capabilities. It supports:
- Synchronous and asynchronous screenshots
- Bulk operations for multiple URLs
- Screenshot composition (combining multiple screenshots)
- Scheduled screenshots with cron expressions
- Usage tracking and quota management

## Installation

Add to `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/allscreenshots/allscreenshots-sdk-swift.git", from: "1.0.0")
]
```

## Authentication

Set the `ALLSCREENSHOTS_API_KEY` environment variable or pass it directly:
```swift
let client = try AllScreenshotsClient()  // Uses environment variable
let client = try AllScreenshotsClient(apiKey: "your-key")  // Explicit key
```

## Common operations

### Take a screenshot
```swift
import AllScreenshotsSDK

let client = try AllScreenshotsClient()
let request = ScreenshotRequest(
    url: "https://example.com",
    device: "Desktop HD",  // or "iPhone 14", "iPad"
    fullPage: true,
    format: .png
)
let imageData = try await client.takeScreenshot(request)
try imageData.write(to: URL(fileURLWithPath: "screenshot.png"))
```

### Available devices
- `Desktop HD` (1920x1080)
- `iPhone 14` (390x844)
- `iPad` (820x1180)

### Screenshot options
- `url`: Target URL (required)
- `device`: Device preset name
- `viewport`: Custom ViewportConfig(width, height, deviceScaleFactor)
- `format`: .png, .jpeg, .webp, .pdf
- `fullPage`: Capture entire scrollable page
- `quality`: 1-100 for JPEG/WebP
- `delay`: Milliseconds to wait before capture
- `waitFor`: CSS selector to wait for
- `waitUntil`: .load, .domcontentloaded, .networkidle
- `darkMode`: Enable dark mode
- `customCss`: Inject custom CSS
- `hideSelectors`: Array of CSS selectors to hide
- `blockAds`: Block advertisements
- `blockCookieBanners`: Block cookie banners

### Bulk screenshots
```swift
let request = BulkRequest(
    urls: [
        BulkUrlRequest(url: "https://example1.com"),
        BulkUrlRequest(url: "https://example2.com")
    ],
    defaults: BulkDefaults(device: "Desktop HD")
)
let job = try await client.createBulkJob(request)
// Poll with client.getBulkJob(job.id)
```

### Compose multiple screenshots
```swift
let request = ComposeRequest(
    captures: [
        CaptureItem(url: "https://example.com", device: "Desktop HD"),
        CaptureItem(url: "https://example.com", device: "iPhone 14")
    ],
    output: ComposeOutputConfig(layout: .grid, columns: 2)
)
let result = try await client.compose(request)
```

### Scheduled screenshots
```swift
let schedule = try await client.createSchedule(CreateScheduleRequest(
    name: "Daily Screenshot",
    url: "https://example.com",
    schedule: "0 9 * * *",  // Cron expression
    timezone: "America/New_York"
))
```

### Check usage
```swift
let quota = try await client.getQuotaStatus()
print("Remaining: \(quota.screenshots.remaining)")
```

## Error handling
```swift
do {
    let image = try await client.takeScreenshot(request)
} catch AllScreenshotsError.unauthorized(let message) {
    // Invalid API key
} catch AllScreenshotsError.validationError(let message, _) {
    // Invalid request parameters
} catch AllScreenshotsError.rateLimitExceeded(let retryAfter) {
    // Rate limited, wait retryAfter seconds
} catch {
    // Other errors
}
```

## Key types

- `AllScreenshotsClient` - Main client class
- `ScreenshotRequest` - Screenshot parameters
- `BulkRequest` - Bulk operation parameters
- `ComposeRequest` - Composition parameters
- `CreateScheduleRequest` - Schedule parameters
- `AllScreenshotsError` - Typed error enum
