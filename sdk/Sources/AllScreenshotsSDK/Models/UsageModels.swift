import Foundation

// MARK: - Quota Response

/// Quota detail response
public struct QuotaDetailResponse: Codable, Sendable {
    public let limit: Int
    public let used: Int
    public let remaining: Int
    public let percentUsed: Int
}

/// Bandwidth quota response
public struct BandwidthQuotaResponse: Codable, Sendable {
    public let limitBytes: Int64
    public let limitFormatted: String
    public let usedBytes: Int64
    public let usedFormatted: String
    public let remainingBytes: Int64
    public let remainingFormatted: String
    public let percentUsed: Int
}

/// Quota status response
public struct QuotaStatusResponse: Codable, Sendable {
    public let tier: String
    public let screenshots: QuotaDetailResponse
    public let bandwidth: BandwidthQuotaResponse
    public let periodEnds: String?
}

// MARK: - Usage Response

/// Quota information
public struct QuotaResponse: Codable, Sendable {
    public let screenshots: Int?
    public let bandwidth: Int64?
}

/// Period usage information
public struct PeriodUsageResponse: Codable, Sendable {
    public let periodStart: String
    public let periodEnd: String
    public let screenshotsCount: Int
    public let bandwidthBytes: Int64
    public let bandwidthFormatted: String
}

/// Total usage information
public struct TotalsResponse: Codable, Sendable {
    public let screenshotsCount: Int64
    public let bandwidthBytes: Int64
    public let bandwidthFormatted: String
}

/// Usage statistics response
public struct UsageResponse: Codable, Sendable {
    public let tier: String
    public let currentPeriod: PeriodUsageResponse
    public let quota: QuotaResponse?
    public let history: [PeriodUsageResponse]?
    public let totals: TotalsResponse?
}
