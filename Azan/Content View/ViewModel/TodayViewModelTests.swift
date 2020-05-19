import XCTest
@testable import Azan

class TodayViewModelTests: XCTestCase {

    var today: Date!

    override func setUp() {
        super.setUp()
        today = Date(timeIntervalSince1970: 1589900089)
    }

    override func tearDown() {
        today = nil
        super.tearDown()
    }

    func test_GivenTodayViewModel_WhenCurrentDateIsSet_ItShouldSetTheCorrectHijriDate() {
        let sut = TodayViewModel(currentDate: today)

        let result = sut.currentHijriDate

        let expected = "Ramadan 26, 1441 AH"

        XCTAssertEqual(result, expected)
    }
}
