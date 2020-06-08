//
//  ForecastViewController.swift
//  WeatherForecast
//
//  Created by Kostiantyn YEFYMENKO on 02.06.20.
//  Copyright © 2020 Kostiantyn YEFYMENKO. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    private var presenter: ForecastPresenterProtocol?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        configureTableView()
        presenter?.viewDidLoad()
    }
    
    func configureTableView() {
        tableView.register(ForecastCell.nib, forCellReuseIdentifier: ForecastCell.reuseKey)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
}

extension ForecastViewController {
    static func make(withPresenter presenter: ForecastPresenterProtocol) -> ForecastViewController? {
        let storyboard = UIStoryboard(name: "Forecast", bundle: Bundle(for: self.classForCoder()))
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ForecastViewController") as? ForecastViewController {
            viewController.presenter = presenter
            return viewController
        } else {
            return nil
        }
    }
}

extension ForecastViewController: ForecastViewProtocol {
    func set(title: String?) {
        navigationItem.title = title
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func showSpinner(_ show: Bool) {
        if show {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.reuseKey, for: indexPath)
        
        if let cell = cell as? ForecastCell, let dayForecast = presenter?.dayForecast(at: indexPath.row) {
            cell.set(dayForecast: dayForecast, row: indexPath.row)
        }
        return cell
    }
}
