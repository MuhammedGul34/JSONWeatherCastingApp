//
//  WheatherAPIError.swift
//  JsonApiHavaTahminUygulamasi
//
//  Created by Muhammed Gül on 13.11.2022.
//

import Foundation

enum wheatherApıError {
    case Requesterror
    case ResponesUnsuccesful(statusCode : Int)
    case InvalidData
    case JSONParcingError
    case invalidURL
}
