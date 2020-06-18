//
//  DrinksViewController.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 17.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class DrinksViewController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2475242077)
        titleView.layer.shadowOpacity = 1
        titleView.layer.shadowRadius = 2
        titleView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "CocktailTableViewCell", bundle: nil), forCellReuseIdentifier: "cocktailCell")
        tableView.dataSource = self
        tableView.delegate = self
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
    }
    
    @IBAction func unwindToDrinksViewController(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

}

extension DrinksViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ordinary drink"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktailCell", for: indexPath) as! CocktailTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 0, width: 200, height: 16)
        myLabel.font = UIFont(name: "Roboto-Regular", size: 14.0)
        myLabel.textColor = #colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.4941176471, alpha: 1)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: 414, height: 40)
        myLabel.center = headerView.center
        headerView.addSubview(myLabel)
        
        return headerView
    }
}
