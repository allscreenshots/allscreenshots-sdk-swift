import XCTest
@testable import AllScreenshotsSDK

final class ErrorTests: XCTestCase {
    func testErrorDescriptions() {
        let errors: [AllScreenshotsError] = [
            .missingApiKey,
            .invalidURL("not-a-url"),
            .invalidRequest("Invalid parameter"),
            .serverError(statusCode: 500, message: "Internal error"),
            .rateLimitExceeded(retryAfter: 60),
            .unauthorized(message: "Invalid API key"),
            .notFound(message: "Resource not found"),
            .validationError(message: "Invalid URL", details: ["url": "Must be a valid URL"]),
            .timeout,
            .unknown("Something went wrong")
        ]

        for error in errors {
            XCTAssertNotNil(error.errorDescription)
            XCTAssertFalse(error.errorDescription!.isEmpty)
        }
    }

    func testStatusCodes() {
        XCTAssertEqual(AllScreenshotsError.serverError(statusCode: 500, message: nil).statusCode, 500)
        XCTAssertEqual(AllScreenshotsError.rateLimitExceeded(retryAfter: nil).statusCode, 429)
        XCTAssertEqual(AllScreenshotsError.unauthorized(message: nil).statusCode, 401)
        XCTAssertEqual(AllScreenshotsError.notFound(message: nil).statusCode, 404)
        XCTAssertEqual(AllScreenshotsError.validationError(message: "", details: nil).statusCode, 400)
        XCTAssertNil(AllScreenshotsError.missingApiKey.statusCode)
        XCTAssertNil(AllScreenshotsError.timeout.statusCode)
    }

    func testRetryability() {
        // Retryable errors
        XCTAssertTrue(AllScreenshotsError.rateLimitExceeded(retryAfter: nil).isRetryable)
        XCTAssertTrue(AllScreenshotsError.timeout.isRetryable)
        XCTAssertTrue(AllScreenshotsError.networkError(URLError(.timedOut)).isRetryable)
        XCTAssertTrue(AllScreenshotsError.serverError(statusCode: 500, message: nil).isRetryable)
        XCTAssertTrue(AllScreenshotsError.serverError(statusCode: 502, message: nil).isRetryable)
        XCTAssertTrue(AllScreenshotsError.serverError(statusCode: 503, message: nil).isRetryable)
        XCTAssertTrue(AllScreenshotsError.serverError(statusCode: 504, message: nil).isRetryable)

        // Non-retryable errors
        XCTAssertFalse(AllScreenshotsError.missingApiKey.isRetryable)
        XCTAssertFalse(AllScreenshotsError.unauthorized(message: nil).isRetryable)
        XCTAssertFalse(AllScreenshotsError.notFound(message: nil).isRetryable)
        XCTAssertFalse(AllScreenshotsError.validationError(message: "", details: nil).isRetryable)
        XCTAssertFalse(AllScreenshotsError.serverError(statusCode: 400, message: nil).isRetryable)
    }

    func testErrorResponseDecoding() throws {
        let decoder = JSONDecoder()

        let json = """
        {
            "error": "validation_error",
            "message": "Invalid URL format",
            "code": "INVALID_URL",
            "details": {
                "url": "Must start with http:// or https://"
            }
        }
        """

        let response = try decoder.decode(ErrorResponse.self, from: json.data(using: .utf8)!)

        XCTAssertEqual(response.error, "validation_error")
        XCTAssertEqual(response.message, "Invalid URL format")
        XCTAssertEqual(response.code, "INVALID_URL")
        XCTAssertEqual(response.details?["url"], "Must start with http:// or https://")
    }
}
