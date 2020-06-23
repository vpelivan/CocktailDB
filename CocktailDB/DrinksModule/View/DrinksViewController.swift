//
//  DrinksViewController.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 17.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class DrinksViewController: UIViewController {

    
    //MARK: - Outlets
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var presenter: DrinksViewPresenterProtocol!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleView()
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print(presenter.filters ?? "")
        proceed()
    }
    
    //MARK: - Private Methods
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "CocktailTableViewCell", bundle: nil), forCellReuseIdentifier: "cocktailCell")
        tableView.tableHeaderView = UIView(frame: .zero)
    }
    
    private func setTitleView() {
        titleView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2475242077)
        titleView.layer.shadowOpacity = 1
        titleView.layer.shadowRadius = 2
        titleView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    @IBAction func tapFilterButton(_ sender: UIButton) {
        let filtersVC = ModuleBuilder.CreateFilters(filters: presenter?.filters, presenter: presenter)
        navigationController?.pushViewController(filtersVC, animated: true)
    }
    
}

//MARK: - TableView Delegate
extension DrinksViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ordinary Drink"
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderInSectionView()
        print(section)
        guard let title = presenter?.filters?.drinks?[section].strCategory else { return headerView }
        headerView.headerLabel.text = title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = presenter.cocktails?.drinks?.count else { return }
        if indexPath.row == count - 1 {
            presenter.performPagination()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        36
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
}

//MARK: - TableView DataSource
extension DrinksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter.cocktails?.drinks?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = presenter.getCell(from: indexPath, for: tableView)
        return cell
    }
}

//MARK: - MVP Protocol Extensions
extension DrinksViewController: DrinksViewProtocol {
    func proceed() {
        tableView.reloadData()
    }
}
