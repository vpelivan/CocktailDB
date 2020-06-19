//
//  NetworkService.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 19.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation
import UIKit

class NetworkService {
    
    public var imageCache = NSCache<NSString, UIImage>() //Image Cache Class
    
    
    //Using A Generic Argument in this method to be able to create universal function for parsing any model type with completion handler closure escaping condition
    
    public func getData<T: Decodable>(into type: T.Type, from url: URL, completion: @escaping (T) -> ()) {
        var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                do
                {
                    print("Status code: ", httpResponse.statusCode)
                    guard let data = data else { return }
                    let decodedData = try JSONDecoder().decode(type.self, from: data)
                    completion(decodedData)
                }
                catch let error {
                    print(error.localizedDescription)
                }
            } else {
                let alertMessage = "For some reasons the request could not be performed"
                self.alert(withTitle: "Request Error", message: alertMessage)
                return
            }
        }
        task.resume()
    }

    //This alert shows in case if the response status code is not valid for loading data
    
    private func alert(withTitle title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        ac.addAction(ok)
        UIApplication.topViewController()?.present(ac, animated: true)
    }
}
