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
    var viewModel: [FilmDetailModelItemProtocol] { get set }
}

class FilmDetailViewController: UIViewController, FilmDetailViewProtocol {
    
    //MARK: - Properties
    private var presenter: FilmDetailPresenterProtocol?
    var viewModel: [FilmDetailModelItemProtocol] = [FilmDetailModelItemProtocol]()
    
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
        tableView.tableFooterView = UIView()
        tableView.register(FilmDetailImageCell.self, forCellReuseIdentifier: FilmDetailImageCell.reuseId)
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
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel[section].rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel[indexPath.section]
        let sectionType = viewModel[indexPath.section].type
        
        let cell = sectionType.cellForModelItemType(tableView: tableView, indexPath: indexPath)
        sectionType.configureCellForModelItemType(cell: cell, data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView(width: tableView.frame.width,
                                           height: 30,
                                           text: viewModel[section].sectionTitle)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel[section].sectionHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}












//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    switch viewModel[indexPath.section].type {
//    case .image:
//        return tableView.dequeueReusableCell(withIdentifier: FilmDetailImageCell.reuseId, for: indexPath)
//        if let cell = tableView.dequeueReusableCell(withIdentifier: FilmDetailImageCell.reuseId, for: indexPath) as? FilmDetailImageCell {
//            cell.set(with: viewModel[indexPath.section])
//            return cell
//        }
//    case .title:
//        if let cell = tableView.dequeueReusableCell(withIdentifier: FilmDetailLabelCell.reuseId, for: indexPath) as? FilmDetailLabelCell {
//            cell.set(with: viewModel[indexPath.section])
//            return cell
//        }
//    case .plot:
//        if let cell = tableView.dequeueReusableCell(withIdentifier: FilmDetailLabelCell.reuseId, for: indexPath) as? FilmDetailLabelCell {
//            cell.set(with: viewModel[indexPath.section])
//            return cell
//        }
//    }
//    return UITableViewCell()
//}
