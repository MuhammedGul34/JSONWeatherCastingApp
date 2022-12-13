//
//  CurrentWeatherModel.swift
//  JsonApiHavaTahminUygulamasi
//
//  Created by Muhammed Gül on 12.11.2022.
//

import Foundation
import UIKit

struct CurrentWeatherModel {
    
    let summary : String
    let icon : UIImage
    let temperature : String
    let humdidity : String
    let precipitationProbability : String
    
    init(data : CurrentWeather) {
        
        self.summary = data.summary
        self.icon = data.iconImage
        self.precipitationProbability = "%\(data.precipProbability * 100)"
        self.temperature = "\(Int(data.temperature))"
        self.humdidity = "%\(Int(data.humidity*100))"
    }
}
