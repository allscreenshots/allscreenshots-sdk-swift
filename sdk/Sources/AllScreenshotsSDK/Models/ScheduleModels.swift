import Foundation

// MARK: - Schedule Screenshot Options

/// Options for scheduled screenshots
public struct ScheduleScreenshotOptions: Codable, Sendable {
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
        self.blockAds = blockAds
        self.blockCookieBanners = blockCookieBanners
        self.blockLevel = blockLevel
    }
}

// MARK: - Create Schedule Request

/// Request to create a scheduled screenshot
public struct CreateScheduleRequest: Codable, Sendable {
    public let name: String
    public let url: String
    public let schedule: String
    public let timezone: String?
    public let options: ScheduleScreenshotOptions?
    public let webhookUrl: String?
    public let webhookSecret: String?
    public let retentionDays: Int?
    public let startsAt: String?
    public let endsAt: String?

    public init(
        name: String,
        url: String,
        schedule: String,
        timezone: String? = nil,
        options: ScheduleScreenshotOptions? = nil,
        webhookUrl: String? = nil,
        webhookSecret: String? = nil,
        retentionDays: Int? = nil,
        startsAt: String? = nil,
        endsAt: String? = nil
    ) {
        self.name = name
        self.url = url
        self.schedule = schedule
        self.timezone = timezone
        self.options = options
        self.webhookUrl = webhookUrl
        self.webhookSecret = webhookSecret
        self.retentionDays = retentionDays
        self.startsAt = startsAt
        self.endsAt = endsAt
    }
}

// MARK: - Update Schedule Request

/// Request to update a scheduled screenshot
public struct UpdateScheduleRequest: Codable, Sendable {
    public let name: String?
    public let url: String?
    public let schedule: String?
    public let timezone: String?
    public let options: ScheduleScreenshotOptions?
    public let webhookUrl: String?
    public let webhookSecret: String?
    public let retentionDays: Int?
    public let startsAt: String?
    public let endsAt: String?

    public init(
        name: String? = nil,
        url: String? = nil,
        schedule: String? = nil,
        timezone: String? = nil,
        options: ScheduleScreenshotOptions? = nil,
        webhookUrl: String? = nil,
        webhookSecret: String? = nil,
        retentionDays: Int? = nil,
        startsAt: String? = nil,
        endsAt: String? = nil
    ) {
        self.name = name
        self.url = url
        self.schedule = schedule
        self.timezone = timezone
        self.options = options
        self.webhookUrl = webhookUrl
        self.webhookSecret = webhookSecret
        self.retentionDays = retentionDays
        self.startsAt = startsAt
        self.endsAt = endsAt
    }
}

// MARK: - Schedule Responses

/// Schedule response
public struct ScheduleResponse: Codable, Sendable {
    public let id: String
    public let name: String
    public let url: String
    public let schedule: String
    public let scheduleDescription: String?
    public let timezone: String?
    public let status: String?
    public let options: ScheduleScreenshotOptions?
    public let webhookUrl: String?
    public let retentionDays: Int?
    public let startsAt: String?
    public let endsAt: String?
    public let lastExecutedAt: String?
    public let nextExecutionAt: String?
    public let executionCount: Int?
    public let successCount: Int?
    public let failureCount: Int?
    public let createdAt: String?
    public let updatedAt: String?
}

/// List of schedules response
public struct ScheduleListResponse: Codable, Sendable {
    public let schedules: [ScheduleResponse]
    public let total: Int
}

/// Schedule execution record
public struct ScheduleExecutionResponse: Codable, Sendable {
    public let id: String
    public let executedAt: String?
    public let status: String?
    public let resultUrl: String?
    public let storageUrl: String?
    public let fileSize: Int64?
    public let renderTimeMs: Int64?
    public let errorCode: String?
    public let errorMessage: String?
    public let expiresAt: String?
}

/// Schedule history response
public struct ScheduleHistoryResponse: Codable, Sendable {
    public let scheduleId: String
    public let totalExecutions: Int64
    public let executions: [ScheduleExecutionResponse]
}
