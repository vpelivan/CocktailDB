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
    func performPagination(for indexPath: IndexPath)
    var cocktails: Cocktails? { get set }
    var filters: Filters? { get set }
    var loadedCocktails: [Cocktails?]  { get set }
}

class DrinksViewPresenter: DrinksViewPresenterProtocol {
    
    //MARK: - Variables
    weak var view: DrinksViewProtocol?
    let networkManager = NetworkManager()
    let networkService = NetworkService()
    var cocktails: Cocktails?
    var loadedCocktails: [Cocktails?] = []
    var filters: Filters?
    var totalCount = 0
    var filterIndex = 0
    
    //MARK: - Interfaces
    required init(view: DrinksViewProtocol) {
        
        self.view = view
        networkManager.getFilters { filters in
            self.filters = filters
            guard let filter = filters?.drinks?.first else { return }
            self.networkManager.getCocktails(with: filter) { cocktails in
                self.cocktails = cocktails
                guard let count = cocktails?.drinks?.count else { return }
                self.totalCount += count
                self.loadedCocktails.append(cocktails)
                self.mapCheckedFilters()
                print("Filters: ", self.filters ?? "no data")
                print("Cocktails: ", self.cocktails ?? "no data")
                self.view?.proceed()
            }
        }
    }
    
    //MARK: - Public Methods
    public func performPagination(for indexPath: IndexPath) {
        guard let count = cocktails?.drinks?.count else { return }
        if indexPath.row == count {
            guard let filter = getNextFilter() else { return }
            networkManager.getCocktails(with: filter) { cocktails in
                guard let count = cocktails?.drinks?.count else { return }
                self.cocktails = cocktails
                self.loadedCocktails.append(cocktails)
                self.totalCount += count
                self.view?.proceed()
            }
        }
    }
    
    public func getCell(from indexPath: IndexPath, for tableView: UITableView) -> CocktailTableViewCell {
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

    //MARK: - Private Methods
    private func getNextFilter() -> DrinkFilter? {
        guard let drinks = self.filters?.drinks else { return nil }
        for filter in drinks {
            if filter.isChecked == true {
                break
            }
            filterIndex += 1
        }
        guard let filter = filters?.drinks?[filterIndex - 1] else { return nil }
        return filter
    }
    
    private func mapCheckedFilters() {
        
        guard let filters = self.filters?.drinks else { return }
        
        for i in 0..<filters.count {
            self.filters?.drinks?[i].isChecked = true
        }
    }
    
}

