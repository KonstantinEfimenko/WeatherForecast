//
//  CitiesListViewController.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 02.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    private var presenter: CitiesListPresenterProtocol?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.viewDidLoad()
    }
    
    func configureTableView() {
        tableView.register(CitiesListCell.nib, forCellReuseIdentifier: CitiesListCell.reuseKey)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
}

extension CitiesListViewController {
    static func make(withPresenter presenter: CitiesListPresenterProtocol) -> CitiesListViewController? {
        let storyboard = UIStoryboard(name: "CitiesList", bundle: Bundle(for: self.classForCoder()))
        if let viewController = storyboard.instantiateViewController(withIdentifier: "CitiesListViewController") as? CitiesListViewController {
            viewController.presenter = presenter
            return viewController
        } else {
            return nil
        }
    }
}

extension CitiesListViewController: CitiesListViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfCities ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CitiesListCell.reuseKey, for: indexPath)
        
        if let cell = cell as? CitiesListCell, let city = presenter?.city(at: indexPath.row) {
            cell.titleLabel?.text = city.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectCity(at: indexPath.row)
    }
}
