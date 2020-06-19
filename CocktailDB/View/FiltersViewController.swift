//
//  FiltersViewController.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 18.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2475242077)
        titleView.layer.shadowOpacity = 1
        titleView.layer.shadowRadius = 2
        titleView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "filterCell")
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToDrinksViewController", sender: nil)
    }
    
}

extension FiltersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterTableViewCell

        return cell
    }
    
    
}
