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
    func reloadResults()
    var cocktails: Cocktails? { get set }
    var filters: Filters? { get set }
    var checkedFilters: [DrinkFilter]? { get set }
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
    var checkedFilters: [DrinkFilter]? = []
    var totalCount: [Int]
    var totalIndex = 0
    var filterIndex = 0
    
    //MARK: - Interfaces
    required init(view: DrinksViewProtocol) {
        self.view = view
        self.totalCount = Array(repeating: 0, count: 11)
        networkManager.getFilters { filters in
            self.filters = filters
            self.mapFilters()
            self.getCoctailsData()
        }
    }
    
    //MARK: - Public Methods
    
    public func getCell(from indexPath: IndexPath, for tableView: UITableView) -> CocktailTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as! CocktailTableViewCell
        
        guard let cocktailName = loadedCocktails[indexPath.section]?.drinks?[indexPath.row].strDrink,
            let imageStr = loadedCocktails[indexPath.section]?.drinks?[indexPath.row].strDrinkThumb, let imageURL = URL(string: imageStr) else { return CocktailTableViewCell() }
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
    
    public func performPagination(for indexPath: IndexPath) {
        print(indexPath.row, totalCount[indexPath.section] - 1)
        if indexPath.row == totalCount[indexPath.section] - 1 {
            getCoctailsData()
        }
    }
    
    public func reloadResults() {
        loadedCocktails = []
        totalCount = Array(repeating: 0, count: 11)
        totalIndex = 0
        checkedFilters = []
        filterIndex = 0
        getCoctailsData()
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
        if filterIndex < drinks.count {
            guard let filter = filters?.drinks?[filterIndex] else { return nil }
            filterIndex += 1
            return filter
        }
        return nil
    }
    
    private func getCoctailsData() {
        guard let filter = getNextFilter() else { return }
        networkManager.getCocktails(with: filter) { cocktails in
            guard let count = cocktails?.drinks?.count else { return }
            self.cocktails = cocktails
            self.loadedCocktails.append(cocktails)
            self.totalCount[self.totalIndex] += count
            self.totalIndex += 1
            print(self.filters ?? "")
            print(self.loadedCocktails)
            self.mapCheckedFilters()
            self.view?.proceed()
        }
    }
    
    private func mapFilters() {
        guard let filters = self.filters?.drinks else { return }
        for i in 0..<filters.count {
            self.filters?.drinks?[i].isChecked = true
        }
    }
    
    private func mapCheckedFilters() {
        guard let filters = self.filters?.drinks else { return }
        for filter in filters {
            if filter.isChecked == true {
                checkedFilters?.append(filter)
            }
        }
    }
    
}

