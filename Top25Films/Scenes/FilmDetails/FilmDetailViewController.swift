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
    func refreshView(imageUrl: URL?)
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
    
    //MARK: - Setup Configuration
    //    private func setup() {
    //        let viewController       = self
    //        let presenter            = FilmDetailPresenter()
    //        viewController.presenter = presenter
    //    }
    
    //MARK: - UIViews
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "name"
        return label
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
        setConstraints()
        presenter?.attachView(view: self)
    }
    
    //MARK: - User functions
    private func setConstraints() {
        view.addSubview(posterImageView)
        view.addSubview(nameLabel)
        view.addSubview(activityIndictator)
        
        activityIndictator.center = view.center
        posterImageView.fillSuperview(padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    //MARK: - TopFilmsViewProtocol
    func refreshView(imageUrl: URL?) {
        posterImageView.setImage(imageUrl: imageUrl)
    }
    
    func loadingView(is loading: Bool) {
        if loading == true {
            posterImageView.isHidden = true
            activityIndictator.isHidden = false
            activityIndictator.startAnimating()
        } else {
            posterImageView.isHidden = false
            activityIndictator.isHidden = true
            activityIndictator.stopAnimating()
        }
    }
}

