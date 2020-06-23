//
//  Cocktails.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 19.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation

// MARK: - Cocktails
struct Cocktails: Decodable {
    var drinks: [Drink]?
}

// MARK: - Drink
struct Drink: Decodable {
    let strDrink: String?
    let strDrinkThumb: String?
    let idDrink: String?
}
