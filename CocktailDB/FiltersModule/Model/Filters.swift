//
//  Filters.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 19.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

// MARK: - Filters
struct Filters: Decodable {
    var drinks: [DrinkFilter]?
}

// MARK: - Drink Filter
struct DrinkFilter: Codable {
    let strCategory: String?
    var isChecked: Bool?
}
