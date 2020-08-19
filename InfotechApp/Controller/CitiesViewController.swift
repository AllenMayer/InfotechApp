//
//  CitiesViewController.swift
//  InfotechApp
//
//  Created by Максим Семений on 18.08.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var cities = [City]()
    var filteredCities = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchController()
        getCities()  
    }
    
    private func configureTableView() {
        tableView.register(CityCell.nib(), forCellReuseIdentifier: CityCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
    }
    
    private func configureSearchController() {
        title = "City Viewer"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter a city..."
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func getCities() {
        CitiesManager.shared.getCityList { [weak self] (cities) in
            self?.cities = cities
        }
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredCities.count
        } else {
            return cities.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as! CityCell
        let city = searchController.isActive ? filteredCities[indexPath.row] : cities[indexPath.row]
        cell.configureCellAt(indexPath: indexPath, cityName: city.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destVC = storyboard?.instantiateViewController(identifier: "CityDetailsController") as! CityDetailsController
        destVC.city = searchController.isActive ? filteredCities[indexPath.row] : cities[indexPath.row]
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
}

extension CitiesViewController: UISearchResultsUpdating {
    
    // Custom Function
    func filterContent(for searchText: String) {
        filteredCities = cities.filter({ (city) -> Bool in
            let name = city.name
            let isMatch = name.localizedCaseInsensitiveContains(searchText)
            return isMatch
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
}

