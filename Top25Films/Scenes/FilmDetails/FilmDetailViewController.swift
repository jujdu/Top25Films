//
//  DetailViewController.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 25.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import Kingfisher

protocol FilmDetailViewProtocol: class {
    func refreshView()
    func loadingView(is loading: Bool)
}

class FilmDetailViewController: UIViewController, FilmDetailViewProtocol {
    
    //MARK: - Properties
    private var presenter: FilmDetailPresenterProtocol?
    
    //MARK: - Inits
    init(with presenter: FilmDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIViews
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    //    let posterImageView: UIImageView = {
    //        let imageView = UIImageView()
    //        imageView.translatesAutoresizingMaskIntoConstraints = false
    //        imageView.clipsToBounds = true
    //        imageView.contentMode = .scaleAspectFill
    //        return imageView
    //    }()
    
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
        view.backgroundColor = .white
        configureTableView()
        setConstraints()
        presenter?.attachView(view: self)
    }
    
    //MARK: - User functions
    private func setConstraints() {
        view.addSubview(activityIndictator)
        view.addSubview(tableView)
        activityIndictator.center = view.center
        
        tableView.fillSuperview()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilmDetailPosterCell.self, forCellReuseIdentifier: FilmDetailPosterCell.reuseId)
        tableView.register(FilmDetailLabelCell.self, forCellReuseIdentifier: FilmDetailLabelCell.reuseId)
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
extension FilmDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: FilmDetailPosterCell.reuseId, for: indexPath) as? FilmDetailPosterCell {
                presenter?.set(cell: cell, section: indexPath.section)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: FilmDetailLabelCell.reuseId, for: indexPath) as? FilmDetailLabelCell {
                presenter?.set(cell: cell, section: indexPath.section)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: FilmDetailLabelCell.reuseId, for: indexPath) as? FilmDetailLabelCell {
                presenter?.set(cell: cell, section: indexPath.section)
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Title"
        case 2:
            return "Plot"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

