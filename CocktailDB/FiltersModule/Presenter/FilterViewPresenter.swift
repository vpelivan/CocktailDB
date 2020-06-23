//
//  FilterViewPresenter.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 22.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation
import UIKit

protocol FilterViewProtocol: class {
    func proceed()
}

protocol FilterViewPresenterProtocol {
    init(view: FilterViewProtocol, filters: Filters?, coctailsPresenter: DrinksViewPresenterProtocol?)
    var filters: Filters? { get set }
    func toggleCheckmark(for row: Int)
    func applyChanges()
}

class FilterViewPresenter: FilterViewPresenterProtocol {
    
    weak var view: FilterViewProtocol?
    weak var coctailsPresenter: DrinksViewPresenterProtocol?
    var filters: Filters?
    
    required init(view: FilterViewProtocol, filters: Filters?, coctailsPresenter: DrinksViewPresenterProtocol?) {
        self.view = view
        self.filters = filters
        self.coctailsPresenter = coctailsPresenter
    }
    
    func toggleCheckmark(for row: Int) {
        filters?.drinks?[row].isChecked?.toggle()
    }
    
    func applyChanges() {
        coctailsPresenter?.filters = filters
    }
}
