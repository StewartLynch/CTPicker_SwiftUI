import XCTest
@testable import CTPicker

final class CTPickerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CTPicker().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
