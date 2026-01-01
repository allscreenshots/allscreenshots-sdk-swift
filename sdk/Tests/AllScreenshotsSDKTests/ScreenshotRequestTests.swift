import XCTest
@testable import AllScreenshotsSDK

final class ScreenshotRequestTests: XCTestCase {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    func testMinimalRequest() throws {
        let request = ScreenshotRequest(url: "https://example.com")

        let json = try encoder.encode(request)
        let decoded = try decoder.decode(ScreenshotRequest.self, from: json)

        XCTAssertEqual(decoded.url, "https://example.com")
        XCTAssertNil(decoded.device)
        XCTAssertNil(decoded.fullPage)
        XCTAssertNil(decoded.format)
    }

    func testFullRequest() throws {
        let request = ScreenshotRequest(
            url: "https://github.com",
            viewport: ViewportConfig(width: 1920, height: 1080, deviceScaleFactor: 2),
            device: "Desktop HD",
            format: .png,
            fullPage: true,
            quality: 90,
            delay: 1000,
            waitFor: "#content",
            waitUntil: .networkidle,
            timeout: 30000,
            darkMode: true,
            customCss: "body { background: red; }",
            hideSelectors: [".ads", ".popup"],
            selector: ".main-content",
            blockAds: true,
            blockCookieBanners: true,
            blockLevel: .pro,
            responseType: .binary
        )

        let json = try encoder.encode(request)
        let decoded = try decoder.decode(ScreenshotRequest.self, from: json)

        XCTAssertEqual(decoded.url, "https://github.com")
        XCTAssertEqual(decoded.viewport?.width, 1920)
        XCTAssertEqual(decoded.viewport?.height, 1080)
        XCTAssertEqual(decoded.viewport?.deviceScaleFactor, 2)
        XCTAssertEqual(decoded.device, "Desktop HD")
        XCTAssertEqual(decoded.format, .png)
        XCTAssertEqual(decoded.fullPage, true)
        XCTAssertEqual(decoded.quality, 90)
        XCTAssertEqual(decoded.delay, 1000)
        XCTAssertEqual(decoded.waitFor, "#content")
        XCTAssertEqual(decoded.waitUntil, .networkidle)
        XCTAssertEqual(decoded.timeout, 30000)
        XCTAssertEqual(decoded.darkMode, true)
        XCTAssertEqual(decoded.customCss, "body { background: red; }")
        XCTAssertEqual(decoded.hideSelectors, [".ads", ".popup"])
        XCTAssertEqual(decoded.selector, ".main-content")
        XCTAssertEqual(decoded.blockAds, true)
        XCTAssertEqual(decoded.blockCookieBanners, true)
        XCTAssertEqual(decoded.blockLevel, .pro)
        XCTAssertEqual(decoded.responseType, .binary)
    }

    func testJSONPropertyNames() throws {
        let request = ScreenshotRequest(
            url: "https://example.com",
            fullPage: true,
            darkMode: true,
            blockAds: true,
            blockCookieBanners: true
        )

        let json = try encoder.encode(request)
        let jsonString = String(data: json, encoding: .utf8)!

        // Verify JSON property names match API spec (camelCase)
        XCTAssertTrue(jsonString.contains("\"fullPage\""))
        XCTAssertTrue(jsonString.contains("\"darkMode\""))
        XCTAssertTrue(jsonString.contains("\"blockAds\""))
        XCTAssertTrue(jsonString.contains("\"blockCookieBanners\""))
    }
}
