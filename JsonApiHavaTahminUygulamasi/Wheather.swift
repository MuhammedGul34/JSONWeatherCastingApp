//
//  Wheather.swift
//  JsonApiHavaTahminUygulamasi
//
//  Created by Muhammed Gül on 13.11.2022.
//

import Foundation

struct Weather {
    let currently  : CurrentWeather
}

extension Weather {
    
    init?(json : [String : AnyObject]) {
        guard let currentWeatherJason = json["current"] as? [String : AnyObject], let currentWeather = CurrentWeather(json: currentWeatherJason) else {
            return nil
        }
        self.currently = currentWeather
        
    }
}
