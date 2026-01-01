import Foundation

/// Policy for retrying failed requests
public struct RetryPolicy: Sendable {
    /// Maximum number of retry attempts
    public let maxRetries: Int
    /// Base delay between retries in seconds
    public let baseDelay: TimeInterval
    /// Maximum delay between retries in seconds
    public let maxDelay: TimeInterval
    /// Multiplier for exponential backoff
    public let multiplier: Double
    /// HTTP status codes that should trigger a retry
    public let retryableStatusCodes: Set<Int>

    /// Default retry policy with 3 retries and exponential backoff
    public static let `default` = RetryPolicy(
        maxRetries: 3,
        baseDelay: 1.0,
        maxDelay: 30.0,
        multiplier: 2.0,
        retryableStatusCodes: [408, 429, 500, 502, 503, 504]
    )

    /// No retry policy
    public static let none = RetryPolicy(
        maxRetries: 0,
        baseDelay: 0,
        maxDelay: 0,
        multiplier: 0,
        retryableStatusCodes: []
    )

    public init(
        maxRetries: Int,
        baseDelay: TimeInterval,
        maxDelay: TimeInterval,
        multiplier: Double,
        retryableStatusCodes: Set<Int>
    ) {
        self.maxRetries = maxRetries
        self.baseDelay = baseDelay
        self.maxDelay = maxDelay
        self.multiplier = multiplier
        self.retryableStatusCodes = retryableStatusCodes
    }

    /// Calculate delay for a given attempt number (0-indexed)
    public func delay(forAttempt attempt: Int) -> TimeInterval {
        let delay = baseDelay * pow(multiplier, Double(attempt))
        return min(delay, maxDelay)
    }

    /// Check if a status code should trigger a retry
    public func shouldRetry(statusCode: Int) -> Bool {
        return retryableStatusCodes.contains(statusCode)
    }

    /// Check if an error should trigger a retry
    public func shouldRetry(error: Error) -> Bool {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut, .networkConnectionLost, .notConnectedToInternet:
                return true
            default:
                return false
            }
        }
        return false
    }
}
