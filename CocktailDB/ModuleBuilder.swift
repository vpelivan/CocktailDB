//
//  ModuleBuilder.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 22.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation
import UIKit

protocol Builder {
    static func CreateDrinks() -> UIViewController
    static func CreateFilters(filters: Filters?, presenter: DrinksViewPresenterProtocol?) -> UIViewController
}

class ModuleBuilder: Builder {
    static func CreateDrinks() -> UIViewController {
        let view = DrinksViewController()
        let presenter = DrinksViewPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func CreateFilters(filters: Filters?, presenter: DrinksViewPresenterProtocol?) -> UIViewController {
        let view = FiltersViewController()
        let presenter = FilterViewPresenter(view: view, filters: filters, coctailsPresenter: presenter)
        view.presenter = presenter
        return view
    }
}
