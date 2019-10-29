//
//  MainViewController.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 25.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol TopFilmsViewProtocol: class {
    func refreshView()
    func loadingView(is loading: Bool)
}

class TopFilmsViewController: UIViewController, TopFilmsViewProtocol {
    
    //MARK: - Properties
    private var presenter: TopFilmsPresenterProtocol?
    
    //MARK: - Inits
    init(with presenter: TopFilmsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup configuration
    private func setup() {
        let viewController       = self
        let router               = TopFilmsRouter(topFilmsViewController: self)
        let presenter            = TopFilmsPresenter(router: router)
        viewController.presenter = presenter
    }
    
    //MARK: - UIViews
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    let activityIndictator: UIActivityIndicatorView = {
        let activityIndictator = UIActivityIndicatorView()
        activityIndictator.hidesWhenStopped = true
        activityIndictator.style = .large
        activityIndictator.color = .gray
        return activityIndictator
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureTableView()
        setConstraints()
        presenter?.attachView(view: self)
        navigationItem.title = "Top 25 Films"
    }
    
    //MARK: - User functions
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TopFilmsCell.self, forCellReuseIdentifier: TopFilmsCell.reuseId)
    }
    
    //MARK: - Constraints
    func setConstraints() {
        view.addSubview(tableView)
        view.addSubview(activityIndictator)
        
        tableView.fillSuperview()
        activityIndictator.center = view.center
    }
    
    //MARK: - TopFilmsViewProtocol
    func refreshView() {
        tableView.reloadData()
    }
    
    func loadingView(is loading: Bool) {
        if loading == true {
            tableView.isHidden = true
            activityIndictator.isHidden = false
            activityIndictator.startAnimating()
        } else {
            tableView.isHidden = false
            activityIndictator.isHidden = true
            activityIndictator.stopAnimating()
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TopFilmsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfBooks ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TopFilmsCell.reuseId, for: indexPath) as? TopFilmsCell {
            presenter?.set(cell: cell, row: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelect(row: indexPath.row)
    }
}
