//
//  CocktailsPresenter.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 22.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import Foundation
import UIKit

protocol DrinksViewProtocol: class {
    func proceed()
}

protocol DrinksViewPresenterProtocol: class {
    init(view: DrinksViewProtocol)
    func getCell(from indexPath: IndexPath, for tableView: UITableView) -> CocktailTableViewCell
    func performPagination()
    var cocktails: Cocktails? { get set }
    var filters: Filters? { get set }
}

class DrinksViewPresenter: DrinksViewPresenterProtocol {
    
    
    weak var view: DrinksViewProtocol?
    let networkManager = NetworkManager()
    let networkService = NetworkService()
    var cocktails: Cocktails?
    var filters: Filters?
    
    required init(view: DrinksViewProtocol) {
        
        self.view = view
        networkManager.getFilters { filters in
            self.filters = filters
            guard let filter = filters?.drinks?.first else { return }
            self.networkManager.getCocktails(with: filter) { cocktails in
                self.cocktails = cocktails
                self.mapCheckedFilters()
                print("Filters: ", self.filters ?? "no data")
                print("Cocktails: ", self.cocktails ?? "no data")
                self.view?.proceed()
            }
        }
    }
    
    func performPagination() {
        let filter = getNextFilter()
        networkManager.getCocktails(with: filter) { cocktails in
            self.cocktails = cocktails
            print("Filters: ", self.filters ?? "no data")
            print("Cocktails: ", self.cocktails ?? "no data")
            self.view?.proceed()
        }
    }
    
    private func getNextFilter() -> DrinkFilter {

        return
    }
    
    private func mapCheckedFilters() {
        
        guard let filters = self.filters?.drinks else { return }
        
        for i in 0..<filters.count {
            self.filters?.drinks?[i].isChecked = true
        }
    }
    
    func getCell(from indexPath: IndexPath, for tableView: UITableView) -> CocktailTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as! CocktailTableViewCell
        guard let cocktailName = cocktails?.drinks?[indexPath.row].strDrink,
            let imageStr = cocktails?.drinks?[indexPath.row].strDrinkThumb, let imageURL = URL(string: imageStr) else { return CocktailTableViewCell() }
        cell.tag = indexPath.row
        cell.cocktailImageView.image = nil
        cell.activityIndicator.startAnimating()
        cell.activityIndicator.isHidden = false
        networkService.getImage(from: imageURL) { (image) in
            cell.cocktailImageView.image = image
            cell.activityIndicator.stopAnimating()
            cell.activityIndicator.isHidden = true
        }
        cell.cocktailNameLabel.text = cocktailName
        return cell

    }
}

