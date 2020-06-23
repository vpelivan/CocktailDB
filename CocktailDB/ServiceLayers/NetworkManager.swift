//
//  NetworkManager.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 23.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    let networkService = NetworkService()
    let urlString = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    func getFilters(completion: @escaping (Filters?) -> ()) {
        
        let listParam = "list.php?c=list"
        guard let baseUrl = URL(string: urlString + listParam) else { return }
        
        networkService.getData(into: Filters.self, from: baseUrl) { result in
            guard let result = result else { return }
            completion(result)
        }
    }
    
    func getCocktails(with filter: DrinkFilter?, completion: @escaping (Cocktails?) -> ()) {

        let filterParam = "filter.php?c="
        guard let filter = filter?.strCategory?.replacingOccurrences(of: " ", with: "%20") else { return }
        guard let url = URL(string: urlString + filterParam + filter) else { return }
        
        networkService.getData(into: Cocktails.self, from: url) { result in
            completion(result)
        }
    }
}
