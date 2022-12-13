//
//  Coordinate.swift
//  JsonApiHavaTahminUygulamasi
//
//  Created by Muhammed Gül on 13.11.2022.
//

import Foundation

struct Coordinate {
    let latitude : Double
    let longitude : Double
}

extension Coordinate : CustomStringConvertible {
    var description: String {
        return "\(latitude),\(longitude)=no"
    }

    static var azerbeycan : Coordinate {
        return Coordinate(latitude: 48.8567, longitude: 2.3508)
      
    }
}


