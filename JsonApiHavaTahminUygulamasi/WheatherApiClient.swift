//
//  WheatherApiClient.swift
//  JsonApiHavaTahminUygulamasi
//
//  Created by Muhammed Gül on 13.11.2022.
//

import Foundation


class WheatherApiClient {
    
    
    fileprivate let apiKeyWheatherApi = "3acb41ef78c14e18bd393402221211"
    
    
    lazy var baseURL : URL = {
        return URL(string: "https://api.weatherapi.com/v1/current.json?key=\(self.apiKeyWheatherApi)&q=q=")!
        
        //https://api.weatherapi.com/v1/current.json?key=3acb41ef78c14e18bd393402221211&q=q=48.8567,2.3508=no
    }()
    
    let downloader = JSONDownloader()
    
    typealias CurrentWheatherTypeCompletionHandler = (CurrentWeather? , wheatherApıError?) -> Void
    typealias WeatherCompletionHandler = (Weather?, wheatherApıError?) -> Void
    private func getWheather(at coordinate : Coordinate , completionHandler completion : @escaping WeatherCompletionHandler) {
        
        
        guard let url = URL(string: coordinate.description, relativeTo: baseURL) else { completion(nil, wheatherApıError.invalidURL)
            return
        }
        let requestURL = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: requestURL) { json, error in
            
            guard let json = json else {
                completion(nil, error)
                return
            }
            
            //demek ki elimizde bir json nesnesi var
            
            guard let weather = Weather(json: json) else {
                completion(nil, wheatherApıError.JSONParcingError)
                return
            }
            completion(weather, nil)
        }
        task.resume()
    }
    
    func getCurrentWeather(at coordinate : Coordinate, completionHandler completion : @escaping CurrentWheatherTypeCompletionHandler){
        getWheather(at: coordinate) { Weather, error in
            completion(Weather?.currently, error)
        }
    }
}
