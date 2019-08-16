//
//  ScooterListViewController.swift
//  Scoot
//
//  Created by Kyle Lee on 8/16/19.
//  Copyright © 2019 Kilo Loco. All rights reserved.
//

import UIKit

final class ScooterListViewController: UITableViewController {
    
    // MARK: - Communication
    
    var getScooters: EmptyClosure?
    
    
    // MARK: - Instance Properties
    
    var scooters = [Scooter]() {
        didSet { tableView.reloadData() }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getScooters?()
    }
    
    
    // MARK: - Setup
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scooters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let scooter = scooters[indexPath.row]
        cell.textLabel?.text = scooter.name
        return cell
    }
}

extension ScooterListViewController: HasScooters {}
