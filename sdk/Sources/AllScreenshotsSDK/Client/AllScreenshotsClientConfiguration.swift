import Foundation

/// Configuration for the AllScreenshots API client
public struct AllScreenshotsClientConfiguration: Sendable {
    /// API key for authentication
    public let apiKey: String
    /// Base URL for the API
    public let baseURL: URL
    /// Request timeout in seconds
    public let timeout: TimeInterval
    /// Retry policy for failed requests
    public let retryPolicy: RetryPolicy
    /// User agent string
    public let userAgent: String

    /// Default base URL for the AllScreenshots API
    public static let defaultBaseURL = URL(string: "https://api.allscreenshots.com")!

    /// Default timeout in seconds
    public static let defaultTimeout: TimeInterval = 60

    /// SDK version
    public static let sdkVersion = "1.0.0"

    /// Creates a new client configuration
    ///
    /// - Parameters:
    ///   - apiKey: API key for authentication. If nil, reads from ALLSCREENSHOTS_API_KEY environment variable.
    ///   - baseURL: Base URL for the API. Defaults to https://api.allscreenshots.com
    ///   - timeout: Request timeout in seconds. Defaults to 60 seconds.
    ///   - retryPolicy: Retry policy for failed requests. Defaults to exponential backoff with 3 retries.
    ///   - userAgent: Custom user agent string. Defaults to SDK identifier.
    /// - Throws: `AllScreenshotsError.missingApiKey` if no API key is provided or found in environment.
    public init(
        apiKey: String? = nil,
        baseURL: URL? = nil,
        timeout: TimeInterval? = nil,
        retryPolicy: RetryPolicy? = nil,
        userAgent: String? = nil
    ) throws {
        // Get API key from parameter or environment variable
        let resolvedApiKey = apiKey ?? ProcessInfo.processInfo.environment["ALLSCREENSHOTS_API_KEY"]
        guard let key = resolvedApiKey, !key.isEmpty else {
            throw AllScreenshotsError.missingApiKey
        }

        self.apiKey = key
        self.baseURL = baseURL ?? Self.defaultBaseURL
        self.timeout = timeout ?? Self.defaultTimeout
        self.retryPolicy = retryPolicy ?? .default
        self.userAgent = userAgent ?? "AllScreenshotsSDK-Swift/\(Self.sdkVersion)"
    }
}

/// Builder for creating client configuration
public final class AllScreenshotsClientConfigurationBuilder: @unchecked Sendable {
    private var apiKey: String?
    private var baseURL: URL?
    private var timeout: TimeInterval?
    private var retryPolicy: RetryPolicy?
    private var userAgent: String?

    public init() {}

    /// Set the API key
    @discardableResult
    public func apiKey(_ apiKey: String) -> Self {
        self.apiKey = apiKey
        return self
    }

    /// Set the base URL
    @discardableResult
    public func baseURL(_ baseURL: URL) -> Self {
        self.baseURL = baseURL
        return self
    }

    /// Set the base URL from a string
    @discardableResult
    public func baseURL(_ baseURL: String) throws -> Self {
        guard let url = URL(string: baseURL) else {
            throw AllScreenshotsError.invalidURL(baseURL)
        }
        self.baseURL = url
        return self
    }

    /// Set the request timeout
    @discardableResult
    public func timeout(_ timeout: TimeInterval) -> Self {
        self.timeout = timeout
        return self
    }

    /// Set the retry policy
    @discardableResult
    public func retryPolicy(_ policy: RetryPolicy) -> Self {
        self.retryPolicy = policy
        return self
    }

    /// Disable retries
    @discardableResult
    public func noRetry() -> Self {
        self.retryPolicy = RetryPolicy.none
        return self
    }

    /// Set a custom user agent
    @discardableResult
    public func userAgent(_ userAgent: String) -> Self {
        self.userAgent = userAgent
        return self
    }

    /// Build the configuration
    public func build() throws -> AllScreenshotsClientConfiguration {
        try AllScreenshotsClientConfiguration(
            apiKey: apiKey,
            baseURL: baseURL,
            timeout: timeout,
            retryPolicy: retryPolicy,
            userAgent: userAgent
        )
    }
}
