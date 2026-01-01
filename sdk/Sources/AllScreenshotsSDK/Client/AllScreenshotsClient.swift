import Foundation

/// Client for interacting with the AllScreenshots API
///
/// ## Overview
///
/// The `AllScreenshotsClient` provides methods to capture screenshots, manage scheduled screenshots,
/// and retrieve usage statistics.
///
/// ## Example
///
/// ```swift
/// // Create client with API key from environment
/// let client = try AllScreenshotsClient()
///
/// // Take a screenshot
/// let imageData = try await client.takeScreenshot(
///     ScreenshotRequest(url: "https://example.com", device: "Desktop HD")
/// )
///
/// // Save the image
/// try imageData.write(to: URL(fileURLWithPath: "screenshot.png"))
/// ```
public final class AllScreenshotsClient: Sendable {
    private let configuration: AllScreenshotsClientConfiguration
    private let session: URLSession
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    // MARK: - Initialization

    /// Creates a new client with the given configuration
    ///
    /// - Parameter configuration: Client configuration
    public init(configuration: AllScreenshotsClientConfiguration) {
        self.configuration = configuration

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = configuration.timeout
        sessionConfig.httpAdditionalHeaders = [
            "User-Agent": configuration.userAgent
        ]
        self.session = URLSession(configuration: sessionConfig)

        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }

    /// Creates a new client with default configuration
    ///
    /// Reads API key from `ALLSCREENSHOTS_API_KEY` environment variable.
    ///
    /// - Throws: `AllScreenshotsError.missingApiKey` if environment variable is not set
    public convenience init() throws {
        let configuration = try AllScreenshotsClientConfiguration()
        self.init(configuration: configuration)
    }

    /// Creates a new client with the specified API key
    ///
    /// - Parameter apiKey: API key for authentication
    public convenience init(apiKey: String) throws {
        let configuration = try AllScreenshotsClientConfiguration(apiKey: apiKey)
        self.init(configuration: configuration)
    }

    /// Creates a new client using a builder
    ///
    /// - Parameter builder: Configuration builder closure
    /// - Returns: Configured client
    public static func builder(_ builder: (AllScreenshotsClientConfigurationBuilder) throws -> Void) throws -> AllScreenshotsClient {
        let configBuilder = AllScreenshotsClientConfigurationBuilder()
        try builder(configBuilder)
        let configuration = try configBuilder.build()
        return AllScreenshotsClient(configuration: configuration)
    }

    // MARK: - Screenshots

    /// Take a screenshot synchronously
    ///
    /// Captures a screenshot of the specified URL and returns the image data.
    ///
    /// - Parameter request: Screenshot request parameters
    /// - Returns: Binary image data
    /// - Throws: `AllScreenshotsError` if the request fails
    ///
    /// ## Example
    ///
    /// ```swift
    /// let request = ScreenshotRequest(
    ///     url: "https://github.com",
    ///     device: "Desktop HD",
    ///     fullPage: true
    /// )
    /// let imageData = try await client.takeScreenshot(request)
    /// ```
    public func takeScreenshot(_ request: ScreenshotRequest) async throws -> Data {
        return try await performRequest(
            method: "POST",
            path: "/v1/screenshots",
            body: request,
            expectBinary: true
        )
    }

    /// Take a screenshot asynchronously
    ///
    /// Starts an asynchronous screenshot job. Use `getJob(_:)` to poll for completion.
    ///
    /// - Parameter request: Screenshot request parameters
    /// - Returns: Async job creation response with job ID
    /// - Throws: `AllScreenshotsError` if the request fails
    public func takeScreenshotAsync(_ request: ScreenshotRequest) async throws -> AsyncJobCreatedResponse {
        return try await performRequest(
            method: "POST",
            path: "/v1/screenshots/async",
            body: request
        )
    }

    /// List all screenshot jobs
    ///
    /// - Returns: Array of job responses
    /// - Throws: `AllScreenshotsError` if the request fails
    public func listJobs() async throws -> [JobResponse] {
        return try await performRequest(
            method: "GET",
            path: "/v1/screenshots/jobs"
        )
    }

    /// Get a specific job by ID
    ///
    /// - Parameter id: Job ID
    /// - Returns: Job response with current status
    /// - Throws: `AllScreenshotsError` if the request fails
    public func getJob(_ id: String) async throws -> JobResponse {
        return try await performRequest(
            method: "GET",
            path: "/v1/screenshots/jobs/\(id)"
        )
    }

    /// Get the result image for a completed job
    ///
    /// - Parameter id: Job ID
    /// - Returns: Binary image data
    /// - Throws: `AllScreenshotsError` if the request fails or job is not completed
    public func getJobResult(_ id: String) async throws -> Data {
        return try await performRequest(
            method: "GET",
            path: "/v1/screenshots/jobs/\(id)/result",
            expectBinary: true
        )
    }

    /// Cancel a screenshot job
    ///
    /// - Parameter id: Job ID
    /// - Returns: Updated job response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func cancelJob(_ id: String) async throws -> JobResponse {
        return try await performRequest(
            method: "POST",
            path: "/v1/screenshots/jobs/\(id)/cancel"
        )
    }

    // MARK: - Bulk Screenshots

    /// Create a bulk screenshot job
    ///
    /// Starts a bulk operation to capture screenshots of multiple URLs.
    ///
    /// - Parameter request: Bulk request with URLs and options
    /// - Returns: Bulk response with job ID and initial status
    /// - Throws: `AllScreenshotsError` if the request fails
    public func createBulkJob(_ request: BulkRequest) async throws -> BulkResponse {
        return try await performRequest(
            method: "POST",
            path: "/v1/screenshots/bulk",
            body: request
        )
    }

    /// List all bulk jobs
    ///
    /// - Returns: Array of bulk job summaries
    /// - Throws: `AllScreenshotsError` if the request fails
    public func listBulkJobs() async throws -> [BulkJobSummary] {
        return try await performRequest(
            method: "GET",
            path: "/v1/screenshots/bulk"
        )
    }

    /// Get bulk job status with details
    ///
    /// - Parameter id: Bulk job ID
    /// - Returns: Detailed bulk status response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func getBulkJob(_ id: String) async throws -> BulkStatusResponse {
        return try await performRequest(
            method: "GET",
            path: "/v1/screenshots/bulk/\(id)"
        )
    }

    /// Cancel a bulk job
    ///
    /// - Parameter id: Bulk job ID
    /// - Returns: Updated bulk job summary
    /// - Throws: `AllScreenshotsError` if the request fails
    public func cancelBulkJob(_ id: String) async throws -> BulkJobSummary {
        return try await performRequest(
            method: "POST",
            path: "/v1/screenshots/bulk/\(id)/cancel"
        )
    }

    // MARK: - Compose

    /// Compose multiple screenshots into one image
    ///
    /// - Parameter request: Compose request with captures and output options
    /// - Returns: Compose response (sync) or job status (async)
    /// - Throws: `AllScreenshotsError` if the request fails
    public func compose(_ request: ComposeRequest) async throws -> ComposeJobStatusResponse {
        return try await performRequest(
            method: "POST",
            path: "/v1/screenshots/compose",
            body: request
        )
    }

    /// Preview layout placement
    ///
    /// - Parameters:
    ///   - layout: Layout type
    ///   - imageCount: Number of images
    ///   - canvasWidth: Canvas width
    ///   - canvasHeight: Canvas height
    ///   - aspectRatios: Aspect ratios for images
    /// - Returns: Layout preview response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func previewLayout(
        layout: LayoutType,
        imageCount: Int,
        canvasWidth: Int? = nil,
        canvasHeight: Int? = nil,
        aspectRatios: [Double]? = nil
    ) async throws -> LayoutPreviewResponse {
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "layout", value: layout.rawValue),
            URLQueryItem(name: "image_count", value: String(imageCount))
        ]
        if let canvasWidth = canvasWidth {
            queryItems.append(URLQueryItem(name: "canvas_width", value: String(canvasWidth)))
        }
        if let canvasHeight = canvasHeight {
            queryItems.append(URLQueryItem(name: "canvas_height", value: String(canvasHeight)))
        }
        if let aspectRatios = aspectRatios {
            queryItems.append(URLQueryItem(name: "aspect_ratios", value: aspectRatios.map { String($0) }.joined(separator: ",")))
        }

        return try await performRequest(
            method: "GET",
            path: "/v1/screenshots/compose/preview",
            queryItems: queryItems
        )
    }

    /// List compose jobs
    ///
    /// - Returns: Array of compose job summaries
    /// - Throws: `AllScreenshotsError` if the request fails
    public func listComposeJobs() async throws -> [ComposeJobSummaryResponse] {
        return try await performRequest(
            method: "GET",
            path: "/v1/screenshots/compose/jobs"
        )
    }

    /// Get compose job status
    ///
    /// - Parameter jobId: Compose job ID
    /// - Returns: Compose job status response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func getComposeJob(_ jobId: String) async throws -> ComposeJobStatusResponse {
        return try await performRequest(
            method: "GET",
            path: "/v1/screenshots/compose/jobs/\(jobId)"
        )
    }

    // MARK: - Schedules

    /// Create a scheduled screenshot
    ///
    /// - Parameter request: Schedule creation request
    /// - Returns: Schedule response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func createSchedule(_ request: CreateScheduleRequest) async throws -> ScheduleResponse {
        return try await performRequest(
            method: "POST",
            path: "/v1/schedules",
            body: request
        )
    }

    /// List all schedules
    ///
    /// - Returns: Schedule list response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func listSchedules() async throws -> ScheduleListResponse {
        return try await performRequest(
            method: "GET",
            path: "/v1/schedules"
        )
    }

    /// Get a specific schedule
    ///
    /// - Parameter id: Schedule ID
    /// - Returns: Schedule response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func getSchedule(_ id: String) async throws -> ScheduleResponse {
        return try await performRequest(
            method: "GET",
            path: "/v1/schedules/\(id)"
        )
    }

    /// Update a schedule
    ///
    /// - Parameters:
    ///   - id: Schedule ID
    ///   - request: Update request
    /// - Returns: Updated schedule response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func updateSchedule(_ id: String, request: UpdateScheduleRequest) async throws -> ScheduleResponse {
        return try await performRequest(
            method: "PUT",
            path: "/v1/schedules/\(id)",
            body: request
        )
    }

    /// Delete a schedule
    ///
    /// - Parameter id: Schedule ID
    /// - Throws: `AllScreenshotsError` if the request fails
    public func deleteSchedule(_ id: String) async throws {
        let _: EmptyResponse = try await performRequest(
            method: "DELETE",
            path: "/v1/schedules/\(id)"
        )
    }

    /// Pause a schedule
    ///
    /// - Parameter id: Schedule ID
    /// - Returns: Updated schedule response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func pauseSchedule(_ id: String) async throws -> ScheduleResponse {
        return try await performRequest(
            method: "POST",
            path: "/v1/schedules/\(id)/pause"
        )
    }

    /// Resume a paused schedule
    ///
    /// - Parameter id: Schedule ID
    /// - Returns: Updated schedule response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func resumeSchedule(_ id: String) async throws -> ScheduleResponse {
        return try await performRequest(
            method: "POST",
            path: "/v1/schedules/\(id)/resume"
        )
    }

    /// Manually trigger a schedule
    ///
    /// - Parameter id: Schedule ID
    /// - Returns: Updated schedule response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func triggerSchedule(_ id: String) async throws -> ScheduleResponse {
        return try await performRequest(
            method: "POST",
            path: "/v1/schedules/\(id)/trigger"
        )
    }

    /// Get schedule execution history
    ///
    /// - Parameters:
    ///   - id: Schedule ID
    ///   - limit: Maximum number of executions to return
    /// - Returns: Schedule history response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func getScheduleHistory(_ id: String, limit: Int? = nil) async throws -> ScheduleHistoryResponse {
        var queryItems: [URLQueryItem] = []
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
        }
        return try await performRequest(
            method: "GET",
            path: "/v1/schedules/\(id)/history",
            queryItems: queryItems.isEmpty ? nil : queryItems
        )
    }

    // MARK: - Usage

    /// Get usage statistics
    ///
    /// - Returns: Usage response with current period and history
    /// - Throws: `AllScreenshotsError` if the request fails
    public func getUsage() async throws -> UsageResponse {
        return try await performRequest(
            method: "GET",
            path: "/v1/usage"
        )
    }

    /// Get quota status
    ///
    /// - Returns: Quota status response
    /// - Throws: `AllScreenshotsError` if the request fails
    public func getQuotaStatus() async throws -> QuotaStatusResponse {
        return try await performRequest(
            method: "GET",
            path: "/v1/usage/quota"
        )
    }

    // MARK: - Private Methods

    private func performRequest<T: Decodable>(
        method: String,
        path: String,
        queryItems: [URLQueryItem]? = nil,
        expectBinary: Bool = false
    ) async throws -> T {
        try await performRequest(
            method: method,
            path: path,
            body: nil as EmptyBody?,
            queryItems: queryItems,
            expectBinary: expectBinary
        )
    }

    private func performRequest<B: Encodable, T: Decodable>(
        method: String,
        path: String,
        body: B?,
        queryItems: [URLQueryItem]? = nil,
        expectBinary: Bool = false
    ) async throws -> T {
        var urlComponents = URLComponents(url: configuration.baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            throw AllScreenshotsError.invalidURL(path)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(configuration.apiKey, forHTTPHeaderField: "X-API-Key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        if let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try encoder.encode(body)
            } catch {
                throw AllScreenshotsError.encodingError(error)
            }
        }

        return try await executeWithRetry(request: request, expectBinary: expectBinary)
    }

    private func executeWithRetry<T: Decodable>(
        request: URLRequest,
        expectBinary: Bool,
        attempt: Int = 0
    ) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw AllScreenshotsError.unknown("Invalid response type")
            }

            // Handle successful responses
            if (200..<300).contains(httpResponse.statusCode) {
                if expectBinary {
                    return data as! T
                }

                // Handle empty responses
                if data.isEmpty || (T.self == EmptyResponse.self) {
                    return EmptyResponse() as! T
                }

                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    throw AllScreenshotsError.decodingError(error)
                }
            }

            // Handle errors
            let error = parseError(statusCode: httpResponse.statusCode, data: data, response: httpResponse)

            // Check if we should retry
            if attempt < configuration.retryPolicy.maxRetries {
                if configuration.retryPolicy.shouldRetry(statusCode: httpResponse.statusCode) {
                    let delay = configuration.retryPolicy.delay(forAttempt: attempt)
                    try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                    return try await executeWithRetry(request: request, expectBinary: expectBinary, attempt: attempt + 1)
                }
            }

            throw error

        } catch let error as AllScreenshotsError {
            throw error
        } catch {
            // Check if we should retry network errors
            if attempt < configuration.retryPolicy.maxRetries && configuration.retryPolicy.shouldRetry(error: error) {
                let delay = configuration.retryPolicy.delay(forAttempt: attempt)
                try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                return try await executeWithRetry(request: request, expectBinary: expectBinary, attempt: attempt + 1)
            }
            throw AllScreenshotsError.networkError(error)
        }
    }

    private func parseError(statusCode: Int, data: Data, response: HTTPURLResponse) -> AllScreenshotsError {
        let errorResponse = try? decoder.decode(ErrorResponse.self, from: data)
        let message = errorResponse?.message ?? errorResponse?.error

        switch statusCode {
        case 400:
            return .validationError(message: message ?? "Bad request", details: errorResponse?.details)
        case 401:
            return .unauthorized(message: message)
        case 404:
            return .notFound(message: message)
        case 429:
            let retryAfter = response.value(forHTTPHeaderField: "Retry-After")
                .flatMap { TimeInterval($0) }
            return .rateLimitExceeded(retryAfter: retryAfter)
        default:
            return .serverError(statusCode: statusCode, message: message)
        }
    }
}

// MARK: - Helper Types

private struct EmptyBody: Encodable {}
private struct EmptyResponse: Decodable {}
