//
//  MainViewController.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 25.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class TopFilmsViewController2: UIViewController {
    
    //MARK: - Properties
    var topFilms: [TopFilm]?
    
    //MARK: - UIViews
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        networkDataFetcher.getTopFilms { [unowned self] (response) in
//            guard let response = response else { return }
//            self.topFilms = response.topFilms
//            self.tableView.reloadData()
//        }
    }
    
    //MARK: - User functions
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.register(TopFilmsCell.self, forCellReuseIdentifier: TopFilmsCell.reuseId)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TopFilmsViewController2: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topFilms?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TopFilmsCell.reuseId, for: indexPath) as? TopFilmsCell {
            guard let film = topFilms?[indexPath.row] else { return UITableViewCell()}
            cell.set(film: film)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = FilmDetailViewController()
        detailVC.filmId = topFilms![indexPath.row].id
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 76
    //    }
}
