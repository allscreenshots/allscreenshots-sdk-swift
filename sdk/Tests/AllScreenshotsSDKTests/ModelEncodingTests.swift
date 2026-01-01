import XCTest
@testable import AllScreenshotsSDK

final class ModelEncodingTests: XCTestCase {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - Bulk Request Tests

    func testBulkRequestEncoding() throws {
        let request = BulkRequest(
            urls: [
                BulkUrlRequest(url: "https://example1.com"),
                BulkUrlRequest(
                    url: "https://example2.com",
                    options: BulkUrlOptions(device: "iPhone 14", fullPage: true)
                )
            ],
            defaults: BulkDefaults(
                device: "Desktop HD",
                format: .png
            )
        )

        let json = try encoder.encode(request)
        let decoded = try decoder.decode(BulkRequest.self, from: json)

        XCTAssertEqual(decoded.urls.count, 2)
        XCTAssertEqual(decoded.urls[0].url, "https://example1.com")
        XCTAssertEqual(decoded.urls[1].url, "https://example2.com")
        XCTAssertEqual(decoded.urls[1].options?.device, "iPhone 14")
        XCTAssertEqual(decoded.defaults?.device, "Desktop HD")
    }

    // MARK: - Compose Request Tests

    func testComposeRequestEncoding() throws {
        let request = ComposeRequest(
            captures: [
                CaptureItem(url: "https://example1.com", label: "Desktop"),
                CaptureItem(url: "https://example2.com", device: "iPhone 14")
            ],
            output: ComposeOutputConfig(
                layout: .grid,
                format: .png,
                columns: 2,
                spacing: 10
            )
        )

        let json = try encoder.encode(request)
        let decoded = try decoder.decode(ComposeRequest.self, from: json)

        XCTAssertEqual(decoded.captures?.count, 2)
        XCTAssertEqual(decoded.captures?[0].label, "Desktop")
        XCTAssertEqual(decoded.output?.layout, .grid)
        XCTAssertEqual(decoded.output?.columns, 2)
    }

    // MARK: - Schedule Request Tests

    func testScheduleRequestEncoding() throws {
        let request = CreateScheduleRequest(
            name: "Daily Screenshot",
            url: "https://example.com",
            schedule: "0 9 * * *",
            timezone: "America/New_York",
            options: ScheduleScreenshotOptions(
                device: "Desktop HD",
                fullPage: true
            ),
            retentionDays: 30
        )

        let json = try encoder.encode(request)
        let decoded = try decoder.decode(CreateScheduleRequest.self, from: json)

        XCTAssertEqual(decoded.name, "Daily Screenshot")
        XCTAssertEqual(decoded.schedule, "0 9 * * *")
        XCTAssertEqual(decoded.timezone, "America/New_York")
        XCTAssertEqual(decoded.options?.device, "Desktop HD")
        XCTAssertEqual(decoded.retentionDays, 30)
    }

    // MARK: - Response Decoding Tests

    func testJobResponseDecoding() throws {
        let json = """
        {
            "id": "job-123",
            "status": "COMPLETED",
            "url": "https://example.com",
            "resultUrl": "https://storage.example.com/result.png",
            "createdAt": "2024-01-15T10:30:00Z",
            "completedAt": "2024-01-15T10:30:05Z"
        }
        """

        let response = try decoder.decode(JobResponse.self, from: json.data(using: .utf8)!)

        XCTAssertEqual(response.id, "job-123")
        XCTAssertEqual(response.status, .completed)
        XCTAssertEqual(response.url, "https://example.com")
        XCTAssertEqual(response.resultUrl, "https://storage.example.com/result.png")
    }

    func testAsyncJobCreatedResponseDecoding() throws {
        let json = """
        {
            "id": "async-job-456",
            "status": "QUEUED",
            "statusUrl": "https://api.example.com/v1/screenshots/jobs/async-job-456",
            "createdAt": "2024-01-15T10:30:00Z"
        }
        """

        let response = try decoder.decode(AsyncJobCreatedResponse.self, from: json.data(using: .utf8)!)

        XCTAssertEqual(response.id, "async-job-456")
        XCTAssertEqual(response.status, .queued)
        XCTAssertEqual(response.statusUrl, "https://api.example.com/v1/screenshots/jobs/async-job-456")
    }

    func testBulkResponseDecoding() throws {
        let json = """
        {
            "id": "bulk-789",
            "status": "PROCESSING",
            "totalJobs": 10,
            "completedJobs": 5,
            "failedJobs": 0,
            "progress": 50,
            "jobs": [
                {"id": "job-1", "url": "https://example1.com", "status": "COMPLETED"},
                {"id": "job-2", "url": "https://example2.com", "status": "PROCESSING"}
            ],
            "createdAt": "2024-01-15T10:30:00Z"
        }
        """

        let response = try decoder.decode(BulkResponse.self, from: json.data(using: .utf8)!)

        XCTAssertEqual(response.id, "bulk-789")
        XCTAssertEqual(response.status, "PROCESSING")
        XCTAssertEqual(response.totalJobs, 10)
        XCTAssertEqual(response.progress, 50)
        XCTAssertEqual(response.jobs?.count, 2)
    }

    func testUsageResponseDecoding() throws {
        let json = """
        {
            "tier": "pro",
            "currentPeriod": {
                "periodStart": "2024-01-01",
                "periodEnd": "2024-01-31",
                "screenshotsCount": 150,
                "bandwidthBytes": 1073741824,
                "bandwidthFormatted": "1 GB"
            },
            "totals": {
                "screenshotsCount": 5000,
                "bandwidthBytes": 10737418240,
                "bandwidthFormatted": "10 GB"
            }
        }
        """

        let response = try decoder.decode(UsageResponse.self, from: json.data(using: .utf8)!)

        XCTAssertEqual(response.tier, "pro")
        XCTAssertEqual(response.currentPeriod.screenshotsCount, 150)
        XCTAssertEqual(response.totals?.screenshotsCount, 5000)
    }

    // MARK: - Enum Encoding Tests

    func testEnumEncodingValues() throws {
        // Test that enums encode to the correct string values
        struct EnumContainer: Codable {
            let format: ImageFormat
            let waitUntil: WaitUntil
            let blockLevel: BlockLevel
            let responseType: ResponseType
            let status: JobStatus
            let layout: LayoutType
            let alignment: Alignment
        }

        let container = EnumContainer(
            format: .webp,
            waitUntil: .networkidle,
            blockLevel: .proPlus,
            responseType: .json,
            status: .processing,
            layout: .masonry,
            alignment: .center
        )

        let json = try encoder.encode(container)
        let jsonString = String(data: json, encoding: .utf8)!

        XCTAssertTrue(jsonString.contains("\"webp\""))
        XCTAssertTrue(jsonString.contains("\"networkidle\""))
        XCTAssertTrue(jsonString.contains("\"pro_plus\""))
        XCTAssertTrue(jsonString.contains("\"JSON\""))
        XCTAssertTrue(jsonString.contains("\"PROCESSING\""))
        XCTAssertTrue(jsonString.contains("\"MASONRY\""))
        XCTAssertTrue(jsonString.contains("\"center\""))
    }
}
