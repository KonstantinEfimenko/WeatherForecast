//
//  ForecastViewControllerTests.swift
//  WeatherForecastUIKitTests
//
//  Created by Kostiantyn YEFYMENKO on 07.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import XCTest
import DataModel

class ForecastViewControllerTests: XCTestCase {
    
    private var presenter: ForecastPresenterProtocol!
    private var viewController: ForecastViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        presenter = ForecastPresenterMock()
        viewController = ForecastViewController.make(withPresenter: presenter)
        presenter.managedView = viewController
    }

    override func tearDownWithError() throws {
        presenter = nil
        viewController = nil
    }

    func testMakeWithPresenter() {
        XCTAssertNotNil(viewController)
    }

    func testViewDidLoad() {
        _ = viewController.view
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testSetTitle() {
        let testTitle = "TestTitle"
        viewController.set(title: testTitle)
        XCTAssertTrue(viewController.navigationItem.title == testTitle)
    }
}

final class ForecastPresenterMock: ForecastPresenterProtocol {
    var managedView: ForecastViewProtocol?
    
    var cityName: String? = ""
    
    var numberOfItems: Int = 4
    
    func viewDidLoad() { }
    
    func dayForecast(at row: Int) -> DayForecast? {
        return nil
    }
}
