//
//  MainViewController.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 25.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol TopFilmsViewProtocol: class {
//    func startLoading()
//    func finishLoading()
    var topFilms: [TopFilm]? { get set }
}

class TopFilmsViewController: UIViewController, TopFilmsViewProtocol {
    
    //MARK: - Properties
    private var presenter: TopFilmsPresenterProtocol?

    var topFilms: [TopFilm]? = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - UIViews
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    //MARK: - Inits
    init(with presenter: TopFilmsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.attachView(view: self)
    }
    
    //MARK: - User functions
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TopFilmsCell.self, forCellReuseIdentifier: TopFilmsCell.reuseId)
        
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TopFilmsViewController: UITableViewDelegate, UITableViewDataSource {
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
}
