//
//  FiltersViewController.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 18.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var presenter: FilterViewPresenterProtocol!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleView()
        setTableView()
        
    }
    
    //MARK: - Private Methods
    private func setTitleView() {
        titleView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2475242077)
        titleView.layer.shadowOpacity = 1
        titleView.layer.shadowRadius = 2
        titleView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    private func setTableView() {
//        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "filterCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - IBActions
    @IBAction func tapBackButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tapApplyButton(_ sender: UIButton) {
        presenter.applyChanges()
    }
    
}


//MARK: - TableView Datasource
extension FiltersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.filters?.drinks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterTableViewCell
        cell.filterLabel.text = presenter?.filters?.drinks?[indexPath.row].strCategory
        guard let check = presenter?.filters?.drinks?[indexPath.row].isChecked else { return FilterTableViewCell() }
        if !check {
            cell.checkmarkImageView.isHidden = true
        } else {
            cell.checkmarkImageView.isHidden = false
        }
        return cell
    }
    
}

//MARK: - TableView Delegate
extension FiltersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.toggleCheckmark(for: indexPath.row)
        proceed()
    }
    
}

extension FiltersViewController: FilterViewProtocol {
    func proceed() {
        tableView.reloadData()
    }
}
