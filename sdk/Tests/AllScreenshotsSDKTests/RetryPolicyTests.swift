import XCTest
@testable import AllScreenshotsSDK

final class RetryPolicyTests: XCTestCase {
    func testDefaultPolicy() {
        let policy = RetryPolicy.default

        XCTAssertEqual(policy.maxRetries, 3)
        XCTAssertEqual(policy.baseDelay, 1.0)
        XCTAssertEqual(policy.maxDelay, 30.0)
        XCTAssertEqual(policy.multiplier, 2.0)
    }

    func testNonePolicy() {
        let policy = RetryPolicy.none

        XCTAssertEqual(policy.maxRetries, 0)
        XCTAssertFalse(policy.shouldRetry(statusCode: 500))
    }

    func testDelayCalculation() {
        let policy = RetryPolicy(
            maxRetries: 5,
            baseDelay: 1.0,
            maxDelay: 30.0,
            multiplier: 2.0,
            retryableStatusCodes: [500]
        )

        XCTAssertEqual(policy.delay(forAttempt: 0), 1.0)
        XCTAssertEqual(policy.delay(forAttempt: 1), 2.0)
        XCTAssertEqual(policy.delay(forAttempt: 2), 4.0)
        XCTAssertEqual(policy.delay(forAttempt: 3), 8.0)
        XCTAssertEqual(policy.delay(forAttempt: 4), 16.0)
        // Should cap at maxDelay
        XCTAssertEqual(policy.delay(forAttempt: 5), 30.0)
        XCTAssertEqual(policy.delay(forAttempt: 10), 30.0)
    }

    func testRetryableStatusCodes() {
        let policy = RetryPolicy.default

        // Should retry
        XCTAssertTrue(policy.shouldRetry(statusCode: 408))
        XCTAssertTrue(policy.shouldRetry(statusCode: 429))
        XCTAssertTrue(policy.shouldRetry(statusCode: 500))
        XCTAssertTrue(policy.shouldRetry(statusCode: 502))
        XCTAssertTrue(policy.shouldRetry(statusCode: 503))
        XCTAssertTrue(policy.shouldRetry(statusCode: 504))

        // Should not retry
        XCTAssertFalse(policy.shouldRetry(statusCode: 200))
        XCTAssertFalse(policy.shouldRetry(statusCode: 400))
        XCTAssertFalse(policy.shouldRetry(statusCode: 401))
        XCTAssertFalse(policy.shouldRetry(statusCode: 403))
        XCTAssertFalse(policy.shouldRetry(statusCode: 404))
    }

    func testRetryableErrors() {
        let policy = RetryPolicy.default

        // Should retry network errors
        XCTAssertTrue(policy.shouldRetry(error: URLError(.timedOut)))
        XCTAssertTrue(policy.shouldRetry(error: URLError(.networkConnectionLost)))
        XCTAssertTrue(policy.shouldRetry(error: URLError(.notConnectedToInternet)))

        // Should not retry other errors
        XCTAssertFalse(policy.shouldRetry(error: URLError(.badURL)))
        XCTAssertFalse(policy.shouldRetry(error: URLError(.cancelled)))
    }
}
