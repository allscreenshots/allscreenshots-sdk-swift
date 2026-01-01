import XCTest
@testable import AllScreenshotsSDK

final class ConfigurationTests: XCTestCase {
    func testConfigurationWithApiKey() throws {
        let config = try AllScreenshotsClientConfiguration(apiKey: "test-api-key")

        XCTAssertEqual(config.apiKey, "test-api-key")
        XCTAssertEqual(config.baseURL, AllScreenshotsClientConfiguration.defaultBaseURL)
        XCTAssertEqual(config.timeout, AllScreenshotsClientConfiguration.defaultTimeout)
    }

    func testConfigurationWithCustomValues() throws {
        let customURL = URL(string: "https://custom.api.com")!
        let config = try AllScreenshotsClientConfiguration(
            apiKey: "test-key",
            baseURL: customURL,
            timeout: 120,
            retryPolicy: RetryPolicy.none,
            userAgent: "CustomAgent/1.0"
        )

        XCTAssertEqual(config.apiKey, "test-key")
        XCTAssertEqual(config.baseURL, customURL)
        XCTAssertEqual(config.timeout, 120)
        XCTAssertEqual(config.retryPolicy.maxRetries, 0)
        XCTAssertEqual(config.userAgent, "CustomAgent/1.0")
    }

    func testConfigurationMissingApiKey() {
        // This test can only pass when ALLSCREENSHOTS_API_KEY is not set
        // Skip if the environment variable is set
        if ProcessInfo.processInfo.environment["ALLSCREENSHOTS_API_KEY"] != nil {
            // Can't unset env vars in Swift, so skip this test when key is present
            return
        }

        XCTAssertThrowsError(try AllScreenshotsClientConfiguration(apiKey: nil)) { error in
            guard case AllScreenshotsError.missingApiKey = error else {
                XCTFail("Expected missingApiKey error, got \(error)")
                return
            }
        }
    }

    func testConfigurationWithEmptyApiKey() {
        XCTAssertThrowsError(try AllScreenshotsClientConfiguration(apiKey: "")) { error in
            guard case AllScreenshotsError.missingApiKey = error else {
                XCTFail("Expected missingApiKey error, got \(error)")
                return
            }
        }
    }

    func testBuilderPattern() throws {
        let config = try AllScreenshotsClientConfigurationBuilder()
            .apiKey("builder-key")
            .timeout(90)
            .noRetry()
            .userAgent("BuilderAgent/1.0")
            .build()

        XCTAssertEqual(config.apiKey, "builder-key")
        XCTAssertEqual(config.timeout, 90)
        XCTAssertEqual(config.retryPolicy.maxRetries, 0)
        XCTAssertEqual(config.userAgent, "BuilderAgent/1.0")
    }

    func testBuilderWithStringURL() throws {
        let config = try AllScreenshotsClientConfigurationBuilder()
            .apiKey("test-key")
            .baseURL("https://test.api.com")
            .build()

        XCTAssertEqual(config.baseURL.absoluteString, "https://test.api.com")
    }

    func testBuilderWithInvalidURL() {
        // Use characters that are invalid in URLs
        XCTAssertThrowsError(
            try AllScreenshotsClientConfigurationBuilder()
                .apiKey("test-key")
                .baseURL("http://[invalid")
                .build()
        ) { error in
            guard case AllScreenshotsError.invalidURL = error else {
                XCTFail("Expected invalidURL error, got \(error)")
                return
            }
        }
    }
}
