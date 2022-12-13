//
//  JSONDownloader.swift
//  JsonApiHavaTahminUygulamasi
//
//  Created by Muhammed Gül on 13.11.2022.
//

import Foundation

class JSONDownloader {
    let session : URLSession
    
    init(config : URLSessionConfiguration) {
        self.session = URLSession(configuration: config)
    }
    convenience init(){
        self.init(config : URLSessionConfiguration.default)
    }
    
    
    typealias JSON = [String : AnyObject]
    typealias JSONDownloaderCompletionHandler = (JSON?, wheatherApıError?) -> Void
    func jsonTask(with request : URLRequest, completionHandler completion : @escaping JSONDownloaderCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                
                completion(nil, wheatherApıError.Requesterror)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                        completion(json, nil)
                    } catch {
                        completion(nil, wheatherApıError.JSONParcingError)
                    }
                    
                    
                } else {
                    // datada sorun varsa veya elde eilemediyse
                    completion(nil, wheatherApıError.InvalidData)
                }
                
            } else {
                // hata meydana gelmiştir.
                completion(nil, wheatherApıError.ResponesUnsuccesful(statusCode: httpResponse.statusCode))
            }
            
        }
        return task
    }
}
