//
//  ForecastByCityConnection.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 02.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import Alamofire
import DataModel
import Foundation
import Utilities

struct HTTPBinResponse: Decodable {
    let list: [ForecastData]
}

public final class ForecastByCityConnection {
    
    private let daysToShow = 4
    
    init(successHandler: ((_ cards: [DayForecast]) -> Void)?,
         failureHandler: ((_ error: String) -> Void)?) {
        let URLString = "https://api.openweathermap.org/data/2.5/forecast?q=Kyiv,ua&APPID=26be89ee1af748edc48498ea7ba3c5c8"
        
        AF.request(URLString).responseJSON { response in
            switch response.result {
            case .success:
                if let jsonData = response.data {
                    self.onGetting(data: jsonData, successHandler: successHandler, failureHandler: failureHandler)
                }
            case .failure(let error):
                failureHandler?(error.localizedDescription)
                if let jsonData = self.offlineData() { // To avoid security limitation in my mac
                    self.onGetting(data: jsonData, successHandler: successHandler, failureHandler: failureHandler)
                }
            }
        }
    }
    
    private func onGetting(data: Data,
                           successHandler: ((_ cards: [DayForecast]) -> Void)?,
                           failureHandler: ((_ error: String) -> Void)?) {
        let jsonDecoder = JSONDecoder()
        do {
            let jsonResponse = try jsonDecoder.decode(HTTPBinResponse.self, from: data)
            
            let list = prepareData(jsonResponse.list)
            successHandler?(list)
        }catch let error{
            failureHandler?(error.localizedDescription)
        }
    }
    
    private func prepareData(_ list: [ForecastData]) -> [DayForecast] {
        var result = [DayForecast]()
        
        var dateString = list.first?.date ?? ""
        var subArray = [ForecastData]()
        for item in list {
            if dateString == item.date  {
                subArray.append(item)
            } else if result.count < daysToShow {
                result.append(DayForecast(date: dateString, array: subArray))
                dateString = item.date
                subArray = [ForecastData]()
                subArray.append(item)
            }
        }
        
        if result.count < daysToShow { // in case of response will return 4 or less days
            result.append(DayForecast(date: dateString, array: subArray))
        }
        
        return result
    }
    
    private func offlineData() -> Data? {
        if let path = Bundle.current.path(forResource: "OfflineData", ofType: "json") {
            return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }

        return nil
    }
}
