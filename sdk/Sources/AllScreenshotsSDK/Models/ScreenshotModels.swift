import Foundation

// MARK: - Enums

/// Image format for screenshots
public enum ImageFormat: String, Codable, Sendable {
    case png
    case jpeg
    case jpg
    case webp
    case pdf
}

/// Wait condition for page loading
public enum WaitUntil: String, Codable, Sendable {
    case load
    case domcontentloaded
    case networkidle
    case commit
}

/// Ad/content blocking level
public enum BlockLevel: String, Codable, Sendable {
    case none
    case light
    case normal
    case pro
    case proPlus = "pro_plus"
    case ultimate
}

/// Response type for screenshot request
public enum ResponseType: String, Codable, Sendable {
    case binary = "BINARY"
    case json = "JSON"
}

/// Job status
public enum JobStatus: String, Codable, Sendable {
    case queued = "QUEUED"
    case processing = "PROCESSING"
    case completed = "COMPLETED"
    case failed = "FAILED"
    case cancelled = "CANCELLED"
}

/// Compose layout type
public enum LayoutType: String, Codable, Sendable {
    case grid = "GRID"
    case horizontal = "HORIZONTAL"
    case vertical = "VERTICAL"
    case masonry = "MASONRY"
    case mondrian = "MONDRIAN"
    case partitioning = "PARTITIONING"
    case auto = "AUTO"
}

/// Vertical alignment
public enum Alignment: String, Codable, Sendable {
    case top
    case center
    case bottom
}

// MARK: - Viewport Configuration

/// Viewport configuration for screenshots
public struct ViewportConfig: Codable, Sendable {
    /// Width in pixels (100-4096)
    public let width: Int?
    /// Height in pixels (100-4096)
    public let height: Int?
    /// Device scale factor (1-3)
    public let deviceScaleFactor: Int?

    public init(width: Int? = nil, height: Int? = nil, deviceScaleFactor: Int? = nil) {
        self.width = width
        self.height = height
        self.deviceScaleFactor = deviceScaleFactor
    }
}

// MARK: - Screenshot Request

/// Request parameters for taking a screenshot
public struct ScreenshotRequest: Codable, Sendable {
    /// Target URL to capture (required)
    public let url: String
    /// Custom viewport configuration
    public let viewport: ViewportConfig?
    /// Device preset name (e.g., "Desktop HD", "iPhone 14", "iPad")
    public let device: String?
    /// Output image format
    public let format: ImageFormat?
    /// Capture full page
    public let fullPage: Bool?
    /// JPEG/WebP quality (1-100)
    public let quality: Int?
    /// Delay before capture in milliseconds (0-30000)
    public let delay: Int?
    /// CSS selector to wait for
    public let waitFor: String?
    /// Wait condition
    public let waitUntil: WaitUntil?
    /// Timeout in milliseconds (1000-60000)
    public let timeout: Int?
    /// Enable dark mode
    public let darkMode: Bool?
    /// Custom CSS to inject (max 10000 chars)
    public let customCss: String?
    /// CSS selectors to hide (max 50)
    public let hideSelectors: [String]?
    /// CSS selector of element to capture (max 500 chars)
    public let selector: String?
    /// Block advertisements
    public let blockAds: Bool?
    /// Block cookie consent banners
    public let blockCookieBanners: Bool?
    /// Content blocking level
    public let blockLevel: BlockLevel?
    /// Webhook URL for async notifications
    public let webhookUrl: String?
    /// Webhook secret for signature verification
    public let webhookSecret: String?
    /// Response type (binary or JSON)
    public let responseType: ResponseType?

    public init(
        url: String,
        viewport: ViewportConfig? = nil,
        device: String? = nil,
        format: ImageFormat? = nil,
        fullPage: Bool? = nil,
        quality: Int? = nil,
        delay: Int? = nil,
        waitFor: String? = nil,
        waitUntil: WaitUntil? = nil,
        timeout: Int? = nil,
        darkMode: Bool? = nil,
        customCss: String? = nil,
        hideSelectors: [String]? = nil,
        selector: String? = nil,
        blockAds: Bool? = nil,
        blockCookieBanners: Bool? = nil,
        blockLevel: BlockLevel? = nil,
        webhookUrl: String? = nil,
        webhookSecret: String? = nil,
        responseType: ResponseType? = nil
    ) {
        self.url = url
        self.viewport = viewport
        self.device = device
        self.format = format
        self.fullPage = fullPage
        self.quality = quality
        self.delay = delay
        self.waitFor = waitFor
        self.waitUntil = waitUntil
        self.timeout = timeout
        self.darkMode = darkMode
        self.customCss = customCss
        self.hideSelectors = hideSelectors
        self.selector = selector
        self.blockAds = blockAds
        self.blockCookieBanners = blockCookieBanners
        self.blockLevel = blockLevel
        self.webhookUrl = webhookUrl
        self.webhookSecret = webhookSecret
        self.responseType = responseType
    }
}

// MARK: - Job Responses

/// Response for async job creation
public struct AsyncJobCreatedResponse: Codable, Sendable {
    public let id: String
    public let status: JobStatus
    public let statusUrl: String?
    public let createdAt: String?
}

/// Job status response
public struct JobResponse: Codable, Sendable {
    public let id: String
    public let status: JobStatus
    public let url: String?
    public let resultUrl: String?
    public let errorCode: String?
    public let errorMessage: String?
    public let createdAt: String?
    public let startedAt: String?
    public let completedAt: String?
    public let expiresAt: String?
    public let metadata: [String: AnyCodable]?
}

// MARK: - Bulk Request/Response

/// Request for a single URL in bulk operations
public struct BulkUrlRequest: Codable, Sendable {
    public let url: String
    public let options: BulkUrlOptions?

    public init(url: String, options: BulkUrlOptions? = nil) {
        self.url = url
        self.options = options
    }
}

/// Options for individual URLs in bulk operations
public struct BulkUrlOptions: Codable, Sendable {
    public let viewport: ViewportConfig?
    public let device: String?
    public let format: ImageFormat?
    public let fullPage: Bool?
    public let quality: Int?
    public let delay: Int?
    public let waitFor: String?
    public let waitUntil: WaitUntil?
    public let timeout: Int?
    public let darkMode: Bool?
    public let customCss: String?
    public let hideSelectors: [String]?
    public let selector: String?
    public let blockAds: Bool?
    public let blockCookieBanners: Bool?
    public let blockLevel: BlockLevel?

    public init(
        viewport: ViewportConfig? = nil,
        device: String? = nil,
        format: ImageFormat? = nil,
        fullPage: Bool? = nil,
        quality: Int? = nil,
        delay: Int? = nil,
        waitFor: String? = nil,
        waitUntil: WaitUntil? = nil,
        timeout: Int? = nil,
        darkMode: Bool? = nil,
        customCss: String? = nil,
        hideSelectors: [String]? = nil,
        selector: String? = nil,
        blockAds: Bool? = nil,
        blockCookieBanners: Bool? = nil,
        blockLevel: BlockLevel? = nil
    ) {
        self.viewport = viewport
        self.device = device
        self.format = format
        self.fullPage = fullPage
        self.quality = quality
        self.delay = delay
        self.waitFor = waitFor
        self.waitUntil = waitUntil
        self.timeout = timeout
        self.darkMode = darkMode
        self.customCss = customCss
        self.hideSelectors = hideSelectors
        self.selector = selector
        self.blockAds = blockAds
        self.blockCookieBanners = blockCookieBanners
        self.blockLevel = blockLevel
    }
}

/// Default options for bulk operations
public struct BulkDefaults: Codable, Sendable {
    public let viewport: ViewportConfig?
    public let device: String?
    public let format: ImageFormat?
    public let fullPage: Bool?
    public let quality: Int?
    public let delay: Int?
    public let waitFor: String?
    public let waitUntil: WaitUntil?
    public let timeout: Int?
    public let darkMode: Bool?
    public let customCss: String?
    public let blockAds: Bool?
    public let blockCookieBanners: Bool?
    public let blockLevel: BlockLevel?

    public init(
        viewport: ViewportConfig? = nil,
        device: String? = nil,
        format: ImageFormat? = nil,
        fullPage: Bool? = nil,
        quality: Int? = nil,
        delay: Int? = nil,
        waitFor: String? = nil,
        waitUntil: WaitUntil? = nil,
        timeout: Int? = nil,
        darkMode: Bool? = nil,
        customCss: String? = nil,
        blockAds: Bool? = nil,
        blockCookieBanners: Bool? = nil,
        blockLevel: BlockLevel? = nil
    ) {
        self.viewport = viewport
        self.device = device
        self.format = format
        self.fullPage = fullPage
        self.quality = quality
        self.delay = delay
        self.waitFor = waitFor
        self.waitUntil = waitUntil
        self.timeout = timeout
        self.darkMode = darkMode
        self.customCss = customCss
        self.blockAds = blockAds
        self.blockCookieBanners = blockCookieBanners
        self.blockLevel = blockLevel
    }
}

/// Bulk screenshot request
public struct BulkRequest: Codable, Sendable {
    public let urls: [BulkUrlRequest]
    public let defaults: BulkDefaults?
    public let webhookUrl: String?
    public let webhookSecret: String?

    public init(
        urls: [BulkUrlRequest],
        defaults: BulkDefaults? = nil,
        webhookUrl: String? = nil,
        webhookSecret: String? = nil
    ) {
        self.urls = urls
        self.defaults = defaults
        self.webhookUrl = webhookUrl
        self.webhookSecret = webhookSecret
    }
}

/// Bulk job info
public struct BulkJobInfo: Codable, Sendable {
    public let id: String
    public let url: String?
    public let status: String?
}

/// Bulk operation response
public struct BulkResponse: Codable, Sendable {
    public let id: String
    public let status: String
    public let totalJobs: Int
    public let completedJobs: Int
    public let failedJobs: Int
    public let progress: Int
    public let jobs: [BulkJobInfo]?
    public let createdAt: String?
    public let completedAt: String?
}

/// Bulk job summary
public struct BulkJobSummary: Codable, Sendable {
    public let id: String
    public let status: String
    public let totalJobs: Int
    public let completedJobs: Int
    public let failedJobs: Int
    public let progress: Int
    public let createdAt: String?
    public let completedAt: String?
}

/// Detailed bulk job info
public struct BulkJobDetailInfo: Codable, Sendable {
    public let id: String
    public let url: String?
    public let status: String?
    public let resultUrl: String?
    public let storageUrl: String?
    public let format: String?
    public let width: Int?
    public let height: Int?
    public let fileSize: Int64?
    public let renderTimeMs: Int64?
    public let errorCode: String?
    public let errorMessage: String?
    public let createdAt: String?
    public let completedAt: String?
}

/// Bulk status response with details
public struct BulkStatusResponse: Codable, Sendable {
    public let id: String
    public let status: String
    public let totalJobs: Int
    public let completedJobs: Int
    public let failedJobs: Int
    public let progress: Int
    public let jobs: [BulkJobDetailInfo]?
    public let createdAt: String?
    public let completedAt: String?
}
