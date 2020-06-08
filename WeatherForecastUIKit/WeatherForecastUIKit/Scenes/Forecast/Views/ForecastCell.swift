//
//  ForecastCell.swift
//  WeatherForecastUIKit
//
//  Created by Kostiantyn YEFYMENKO on 03.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import AlamofireImage
import DataModel
import DataService
import UIKit
import Utilities

class ForecastCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var minTempValueLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var maxTempValueLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 6
        
        temperatureLabel.textColor = UIColor(named: "colorTemperature")
        temperatureLabel.font = .boldSystemFont(ofSize: 40)
        
        minTempLabel.text = "forecast_minTempLabel".localized
        minTempLabel.textColor = .blue
        minTempValueLabel.textColor = .blue
        minTempValueLabel.font = .boldSystemFont(ofSize: 22)
        
        maxTempLabel.text = "forecast_maxTempLabel".localized
        maxTempLabel.textColor = .red
        maxTempValueLabel.textColor = .red
        maxTempValueLabel.font = .boldSystemFont(ofSize: 22)
        
        feelsLikeLabel.textColor = .gray
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cleanView()
    }
    
    fileprivate func cleanView() {
        dateLabel.text = nil
        dayImageView.image = nil
        minTempValueLabel.text = nil
        maxTempValueLabel.text = nil
        temperatureLabel.text = nil
        feelsLikeLabel.text = nil
    }
    
    func set(dayForecast: DayForecast, row: Int) {
        dateLabel.text = dateString(for: row, date: dayForecast.date)
        temperatureLabel.text = "\(Int(dayForecast.temp)) ℃"
        minTempValueLabel.text = "\(Int(dayForecast.tempMin)) ℃"
        maxTempValueLabel.text = "\(Int(dayForecast.tempMax)) ℃"
        feelsLikeLabel.text = "forecast_feelsLikeLabel".localized.replacingOccurrences(of: "#VALUE#", with: "\(Int(dayForecast.feelsLike))") + " ℃"
        
        if let url = URL(string: "http://openweathermap.org/img/w/\(dayForecast.icon).png") {
            dayImageView.af.setImage(withURL: url)
        }
        
    }
    
    func dateString(for row: Int, date: String) -> String {
        switch row {
        case 0:
            return "today".localized
        case 1:
            return "tomorrow".localized
        default:
            return date
        }
    }
    
}
