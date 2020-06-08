import XCTest
@testable import DataModel

final class DataModelTests: XCTestCase {
    
    func testSum() {
        let floatArray = [4.5, 5.4]
        XCTAssertEqual(floatArray.sum(), 9.9)
    }
    
    func testAverage() {
        let floatArray = [4.5, 5.4]
        XCTAssertEqual(floatArray.average(), 4.95)
    }
    
    func testInitWithDateArray() {
        let initialDate = "2020-06-03"
        let initialArray = [ForecastData(main: MainForecastData(temp: 333.7, feelsLike: 331.2, tempMin: 330.0, tempMax: 340.2), weather: [WeatherForecastData(icon: "10d")], dt_txt: "2020-06-03 15:00:00"),
        ForecastData(main: MainForecastData(temp: 335.7, feelsLike: 332.2, tempMin: 329.0, tempMax: 341.2), weather: [WeatherForecastData(icon: "10d")], dt_txt: "2020-06-03 18:00:00")]
        
        let dayForecast = DayForecast(date: initialDate, array: initialArray)
        
        XCTAssertEqual(dayForecast.temp, 61)
        XCTAssertEqual(dayForecast.feelsLike, 58)
        XCTAssertEqual(dayForecast.tempMin, 55)
        XCTAssertEqual(dayForecast.tempMax, 68)
    }

    static var allTests = [
        ("testSum", testSum),
        ("testAverage", testAverage)
    ]
}
