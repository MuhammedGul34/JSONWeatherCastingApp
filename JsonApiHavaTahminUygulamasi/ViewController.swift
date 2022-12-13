//
//  ViewController.swift
//  JsonApiHavaTahminUygulamasi
//
//  Created by Muhammed Gül on 12.11.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var lblTempreature: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblPrecipititaion: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var btnRefresh: UIButton!
    @IBOutlet weak var wheatherIcon: UIImageView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    var locationManager = CLLocationManager()
    
    let client = WheatherApiClient()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        self.locationManager.delegate = self
        // uygulama açıldığında kullanıcıdan konum bilgisini paylaşmayı isteyecek
        self.locationManager.requestWhenInUseAuthorization()
        // konum servisi cihazda açık mı ?
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //konum bilgisini almaya başlayacak
            locationManager.startUpdatingLocation()
        }
        
    }
    //konum bilgisi değişirse kod bloğu çalışacak
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue : CLLocationCoordinate2D = manager.location!.coordinate
        let clientCoordinate = Coordinate(latitude: locationValue.latitude, longitude: locationValue.longitude)
        print("Latitude: \(clientCoordinate.latitude), Longitude: \(clientCoordinate.longitude)")
        updateWeather(coordinate: clientCoordinate)
    }
    
    func updateWeather(coordinate : Coordinate){
        client.getCurrentWeather(at: coordinate) { currentWeather, error in
           
            print(currentWeather)
            print(error)
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherModel(data: currentWeather)
                
                DispatchQueue.main.sync {
                    self.showWeather(model: viewModel)
                }
            }
                
        }
    }
    
    func showWeather (model : CurrentWeatherModel) {
        lblSummary.text = model.summary
        lblHumidity.text = model.humdidity
        lblTempreature.text = model.temperature
        lblPrecipititaion.text = model.precipitationProbability
        wheatherIcon.image = model.icon
        indicator.stopAnimating()
    }
    
    @IBAction func btnRefreshedClicked(_ sender: UIButton) {
        
        indicator.startAnimating()
        locationManager(locationManager, didUpdateLocations: [])
    }
    
    
}

