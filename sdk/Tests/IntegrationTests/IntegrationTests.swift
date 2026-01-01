import XCTest
@testable import AllScreenshotsSDK

/// Integration tests for the AllScreenshots SDK
///
/// These tests make real API calls and require the `ALLSCREENSHOTS_API_KEY` environment variable.
/// Run with: `swift test --filter IntegrationTests`
final class IntegrationTests: XCTestCase {
    private var client: AllScreenshotsClient!
    private var testResults: [TestResult] = []
    private let startTime = Date()

    struct TestResult {
        let id: String
        let name: String
        let url: String
        let device: String
        let fullPage: Bool
        let passed: Bool
        let errorMessage: String?
        let imageData: Data?
        let executionTimeMs: Int64
    }

    override func setUp() async throws {
        guard ProcessInfo.processInfo.environment["ALLSCREENSHOTS_API_KEY"] != nil else {
            throw XCTSkip("ALLSCREENSHOTS_API_KEY environment variable is not set")
        }
        client = try AllScreenshotsClient()
    }

    override func tearDown() async throws {
        // Generate report after all tests
        if !testResults.isEmpty {
            generateHTMLReport()
        }
    }

    // MARK: - Test Cases

    /// IT-001: Basic Desktop Screenshot
    func testIT001_BasicDesktopScreenshot() async throws {
        let startTime = Date()
        var result: TestResult

        do {
            let request = ScreenshotRequest(
                url: "https://github.com",
                device: "Desktop HD",
                fullPage: false
            )
            let imageData = try await client.takeScreenshot(request)

            XCTAssertGreaterThan(imageData.count, 0, "Image data should not be empty")

            result = TestResult(
                id: "IT-001",
                name: "Basic Desktop Screenshot",
                url: "https://github.com",
                device: "Desktop HD",
                fullPage: false,
                passed: true,
                errorMessage: nil,
                imageData: imageData,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
        } catch {
            result = TestResult(
                id: "IT-001",
                name: "Basic Desktop Screenshot",
                url: "https://github.com",
                device: "Desktop HD",
                fullPage: false,
                passed: false,
                errorMessage: error.localizedDescription,
                imageData: nil,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
            throw error
        }

        testResults.append(result)
    }

    /// IT-002: Basic Mobile Screenshot
    func testIT002_BasicMobileScreenshot() async throws {
        let startTime = Date()
        var result: TestResult

        do {
            let request = ScreenshotRequest(
                url: "https://github.com",
                device: "iPhone 14",
                fullPage: false
            )
            let imageData = try await client.takeScreenshot(request)

            XCTAssertGreaterThan(imageData.count, 0, "Image data should not be empty")

            result = TestResult(
                id: "IT-002",
                name: "Basic Mobile Screenshot",
                url: "https://github.com",
                device: "iPhone 14",
                fullPage: false,
                passed: true,
                errorMessage: nil,
                imageData: imageData,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
        } catch {
            result = TestResult(
                id: "IT-002",
                name: "Basic Mobile Screenshot",
                url: "https://github.com",
                device: "iPhone 14",
                fullPage: false,
                passed: false,
                errorMessage: error.localizedDescription,
                imageData: nil,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
            throw error
        }

        testResults.append(result)
    }

    /// IT-003: Basic Tablet Screenshot
    func testIT003_BasicTabletScreenshot() async throws {
        let startTime = Date()
        var result: TestResult

        do {
            let request = ScreenshotRequest(
                url: "https://github.com",
                device: "iPad",
                fullPage: false
            )
            let imageData = try await client.takeScreenshot(request)

            XCTAssertGreaterThan(imageData.count, 0, "Image data should not be empty")

            result = TestResult(
                id: "IT-003",
                name: "Basic Tablet Screenshot",
                url: "https://github.com",
                device: "iPad",
                fullPage: false,
                passed: true,
                errorMessage: nil,
                imageData: imageData,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
        } catch {
            result = TestResult(
                id: "IT-003",
                name: "Basic Tablet Screenshot",
                url: "https://github.com",
                device: "iPad",
                fullPage: false,
                passed: false,
                errorMessage: error.localizedDescription,
                imageData: nil,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
            throw error
        }

        testResults.append(result)
    }

    /// IT-004: Full Page Desktop
    func testIT004_FullPageDesktop() async throws {
        let startTime = Date()
        var result: TestResult

        do {
            let request = ScreenshotRequest(
                url: "https://github.com",
                device: "Desktop HD",
                fullPage: true
            )
            let imageData = try await client.takeScreenshot(request)

            XCTAssertGreaterThan(imageData.count, 0, "Image data should not be empty")

            result = TestResult(
                id: "IT-004",
                name: "Full Page Desktop",
                url: "https://github.com",
                device: "Desktop HD",
                fullPage: true,
                passed: true,
                errorMessage: nil,
                imageData: imageData,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
        } catch {
            result = TestResult(
                id: "IT-004",
                name: "Full Page Desktop",
                url: "https://github.com",
                device: "Desktop HD",
                fullPage: true,
                passed: false,
                errorMessage: error.localizedDescription,
                imageData: nil,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
            throw error
        }

        testResults.append(result)
    }

    /// IT-005: Full Page Mobile
    func testIT005_FullPageMobile() async throws {
        let startTime = Date()
        var result: TestResult

        do {
            let request = ScreenshotRequest(
                url: "https://github.com",
                device: "iPhone 14",
                fullPage: true
            )
            let imageData = try await client.takeScreenshot(request)

            XCTAssertGreaterThan(imageData.count, 0, "Image data should not be empty")

            result = TestResult(
                id: "IT-005",
                name: "Full Page Mobile",
                url: "https://github.com",
                device: "iPhone 14",
                fullPage: true,
                passed: true,
                errorMessage: nil,
                imageData: imageData,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
        } catch {
            result = TestResult(
                id: "IT-005",
                name: "Full Page Mobile",
                url: "https://github.com",
                device: "iPhone 14",
                fullPage: true,
                passed: false,
                errorMessage: error.localizedDescription,
                imageData: nil,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
            throw error
        }

        testResults.append(result)
    }

    /// IT-006: Complex Page
    func testIT006_ComplexPage() async throws {
        let startTime = Date()
        var result: TestResult

        do {
            let request = ScreenshotRequest(
                url: "https://github.com/anthropics/claude-code",
                device: "Desktop HD",
                fullPage: false
            )
            let imageData = try await client.takeScreenshot(request)

            XCTAssertGreaterThan(imageData.count, 0, "Image data should not be empty")

            result = TestResult(
                id: "IT-006",
                name: "Complex Page",
                url: "https://github.com/anthropics/claude-code",
                device: "Desktop HD",
                fullPage: false,
                passed: true,
                errorMessage: nil,
                imageData: imageData,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
        } catch {
            result = TestResult(
                id: "IT-006",
                name: "Complex Page",
                url: "https://github.com/anthropics/claude-code",
                device: "Desktop HD",
                fullPage: false,
                passed: false,
                errorMessage: error.localizedDescription,
                imageData: nil,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
            throw error
        }

        testResults.append(result)
    }

    /// IT-007: Invalid URL
    func testIT007_InvalidURL() async throws {
        let startTime = Date()
        var result: TestResult

        do {
            let request = ScreenshotRequest(
                url: "not-a-valid-url",
                device: "Desktop HD",
                fullPage: false
            )
            _ = try await client.takeScreenshot(request)

            // If we get here, the test failed (should have thrown an error)
            result = TestResult(
                id: "IT-007",
                name: "Invalid URL",
                url: "not-a-valid-url",
                device: "Desktop HD",
                fullPage: false,
                passed: false,
                errorMessage: "Expected validation error but request succeeded",
                imageData: nil,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
            XCTFail("Expected validation error for invalid URL")
        } catch {
            // Expected behavior - validation error
            result = TestResult(
                id: "IT-007",
                name: "Invalid URL",
                url: "not-a-valid-url",
                device: "Desktop HD",
                fullPage: false,
                passed: true,
                errorMessage: nil,
                imageData: nil,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
        }

        testResults.append(result)
    }

    /// IT-008: Unreachable URL
    func testIT008_UnreachableURL() async throws {
        let startTime = Date()
        var result: TestResult

        do {
            let request = ScreenshotRequest(
                url: "https://this-domain-does-not-exist-12345.com",
                device: "Desktop HD",
                fullPage: false
            )
            _ = try await client.takeScreenshot(request)

            // If we get here, the test failed (should have thrown an error)
            result = TestResult(
                id: "IT-008",
                name: "Unreachable URL",
                url: "https://this-domain-does-not-exist-12345.com",
                device: "Desktop HD",
                fullPage: false,
                passed: false,
                errorMessage: "Expected error for unreachable URL but request succeeded",
                imageData: nil,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
            XCTFail("Expected error for unreachable URL")
        } catch {
            // Expected behavior - error handled gracefully
            result = TestResult(
                id: "IT-008",
                name: "Unreachable URL",
                url: "https://this-domain-does-not-exist-12345.com",
                device: "Desktop HD",
                fullPage: false,
                passed: true,
                errorMessage: nil,
                imageData: nil,
                executionTimeMs: Int64(Date().timeIntervalSince(startTime) * 1000)
            )
        }

        testResults.append(result)
    }

    // MARK: - Report Generation

    private func generateHTMLReport() {
        let passed = testResults.filter { $0.passed }.count
        let failed = testResults.count - passed
        let totalTime = Int64(Date().timeIntervalSince(startTime) * 1000)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestamp = dateFormatter.string(from: Date())

        var html = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>AllScreenshots SDK Swift - Integration Test Report</title>
            <style>
                * { box-sizing: border-box; margin: 0; padding: 0; }
                body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; line-height: 1.6; color: #333; background: #f5f5f5; padding: 20px; }
                .container { max-width: 1200px; margin: 0 auto; }
                .header { background: #fff; padding: 30px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
                .header h1 { font-size: 24px; margin-bottom: 10px; }
                .header .meta { color: #666; font-size: 14px; }
                .summary { display: flex; gap: 20px; margin-bottom: 20px; }
                .summary-card { flex: 1; background: #fff; padding: 20px; border-radius: 8px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
                .summary-card .value { font-size: 36px; font-weight: bold; }
                .summary-card .label { color: #666; font-size: 14px; }
                .summary-card.passed .value { color: #22c55e; }
                .summary-card.failed .value { color: #ef4444; }
                .test-card { background: #fff; padding: 20px; border-radius: 8px; margin-bottom: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
                .test-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
                .test-title { font-size: 18px; font-weight: 600; }
                .badge { padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
                .badge.passed { background: #dcfce7; color: #166534; }
                .badge.failed { background: #fee2e2; color: #991b1b; }
                .test-details { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 10px; margin-bottom: 15px; }
                .detail-item { padding: 10px; background: #f9f9f9; border-radius: 4px; }
                .detail-label { font-size: 12px; color: #666; }
                .detail-value { font-weight: 500; }
                .screenshot { max-width: 100%; border: 1px solid #e5e5e5; border-radius: 4px; }
                .error-message { background: #fee2e2; color: #991b1b; padding: 10px; border-radius: 4px; font-size: 14px; }
                .footer { text-align: center; color: #666; font-size: 14px; padding: 20px; }
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">
                    <h1>AllScreenshots SDK Swift - Integration Test Report</h1>
                    <div class="meta">
                        <p>Version: 1.0.0 | Generated: \(timestamp)</p>
                    </div>
                </div>

                <div class="summary">
                    <div class="summary-card">
                        <div class="value">\(testResults.count)</div>
                        <div class="label">Total Tests</div>
                    </div>
                    <div class="summary-card passed">
                        <div class="value">\(passed)</div>
                        <div class="label">Passed</div>
                    </div>
                    <div class="summary-card failed">
                        <div class="value">\(failed)</div>
                        <div class="label">Failed</div>
                    </div>
                    <div class="summary-card">
                        <div class="value">\(totalTime)ms</div>
                        <div class="label">Total Time</div>
                    </div>
                </div>
        """

        for result in testResults {
            let badgeClass = result.passed ? "passed" : "failed"
            let badgeText = result.passed ? "PASSED" : "FAILED"

            html += """

                <div class="test-card">
                    <div class="test-header">
                        <span class="test-title">\(result.id): \(result.name)</span>
                        <span class="badge \(badgeClass)">\(badgeText)</span>
                    </div>
                    <div class="test-details">
                        <div class="detail-item">
                            <div class="detail-label">URL</div>
                            <div class="detail-value">\(result.url)</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Device</div>
                            <div class="detail-value">\(result.device)</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Full Page</div>
                            <div class="detail-value">\(result.fullPage)</div>
                        </div>
                        <div class="detail-item">
                            <div class="detail-label">Execution Time</div>
                            <div class="detail-value">\(result.executionTimeMs)ms</div>
                        </div>
                    </div>
            """

            if let errorMessage = result.errorMessage {
                html += """
                    <div class="error-message">\(errorMessage)</div>
                """
            }

            if let imageData = result.imageData {
                let base64 = imageData.base64EncodedString()
                html += """
                    <img class="screenshot" src="data:image/png;base64,\(base64)" alt="Screenshot">
                """
            }

            html += """
                </div>
            """
        }

        let swiftVersion = "5.9+"
        html += """

                <div class="footer">
                    <p>Environment: \(ProcessInfo.processInfo.operatingSystemVersionString) | Swift \(swiftVersion)</p>
                </div>
            </div>
        </body>
        </html>
        """

        // Write report to file
        let reportPath = FileManager.default.currentDirectoryPath + "/test-report.html"
        do {
            try html.write(toFile: reportPath, atomically: true, encoding: .utf8)
            print("Integration test report generated: \(reportPath)")
        } catch {
            print("Failed to write test report: \(error)")
        }
    }
}
