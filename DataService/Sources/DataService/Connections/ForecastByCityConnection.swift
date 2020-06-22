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

enum MyError: Error {
    case networkError
    case generalError
}

public final class ForecastByCityConnection {
    
    private let daysToShow = 4
    
    init(with city: String, completion: ((Result<[DayForecast], Error>) -> Void)?) {
        let URLString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&APPID=26be89ee1af748edc48498ea7ba3c5c8"
        
        AF.request(URLString).responseJSON { response in
            switch response.result {
            case .success:
            
                guard let jsonData = response.data else {
                    completion?(Result.failure(MyError.generalError))
                    return
                }
                let result = self.onGetting(data: jsonData)
                completion?(result)
                
            case .failure(let error):
                completion?(Result.failure(error))
            }
        }
    }
    
    private func onGetting(data: Data) -> Result<[DayForecast],Error> {
        let jsonDecoder = JSONDecoder()
        return Result { try prepareData(jsonDecoder.decode(HTTPBinResponse.self, from: data).list) }
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
    
    // Use it in case of security restrictions in network
    private func offlineData() -> Result<Data?, Error> {
        if let path = Bundle.current.path(forResource: "OfflineData", ofType: "json") {
            return Result { try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) }
        }

        return Result.failure(MyError.generalError)
    }
}
