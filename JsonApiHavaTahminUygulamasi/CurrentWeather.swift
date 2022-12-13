//
//  CurrentWeather.swift
//  JsonApiHavaTahminUygulamasi
//
//  Created by Muhammed Gül on 12.11.2022.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature : Double
    let precipProbability : Double
    let summary : String
    let humidity : Double
    let icon : String
    
    init(temperature : Double, precipProbability : Double, summary : String, humidity : Double, icon : String
    ) {
        self.temperature = temperature
        self.precipProbability = precipProbability
        self.summary = summary
        self.humidity = humidity
        self.icon = icon
    }
}

extension CurrentWeather {
    
    var iconImage : UIImage {
        
        switch icon {
        case "clear-day" : return UIImage(imageLiteralResourceName: "clear-day")
        case "clear-night" : return UIImage(imageLiteralResourceName: "clear-night")
        case "rain" : return UIImage(imageLiteralResourceName: "rain")
        case "snow" : return UIImage(imageLiteralResourceName: "snow")
        case "sleet" : return UIImage(imageLiteralResourceName: "sleet")
        case "wind" : return UIImage(imageLiteralResourceName: "wind")
        case "fog" : return UIImage(imageLiteralResourceName: "fog")
        case "cloudy" : return UIImage(imageLiteralResourceName: "cloudy")
        case "partly-cloudy-night" : return UIImage(imageLiteralResourceName: "partly-cloudy-night")
        case  "partly-cloudy-day" : return UIImage(imageLiteralResourceName: "partly-cloudy-day")
        default : return UIImage(imageLiteralResourceName: "default")
        }
    }
}

extension CurrentWeather {
    
    struct Key {
        static let temperature = "temp_c"
        static let icon = "icon" // DEĞİŞMEDİ
        static let summary = "text"
        static let humidity = "humidity"
        static let precipProbability = "precip_mm"
        
    }
    
    init?(json : [String : AnyObject]) {
        guard let temp = json[Key.temperature] as? Double,
              let iconStr = json[Key.icon] as? String,
              let sum = json[Key.summary] as? String,
              let hum = json[Key.humidity] as? Double,
              let precipProp = json[Key.precipProbability] as? Double else {
            return nil
        }
        self.humidity = hum
        self.summary = sum
        self.precipProbability = precipProp
        self.icon = iconStr
        self.temperature = (temp - 32) / 1.8
                
    }
    
}
