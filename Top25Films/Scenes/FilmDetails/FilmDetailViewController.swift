//
//  DetailViewController.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 25.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import Kingfisher

class FilmDetailViewController: UIViewController {
    
    let networkDataFetcher = NetworkDataFetcher()
    var filmId: String!
    var film: Film!
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        
        networkDataFetcher.getAFilm(id: filmId) { (response) in
            guard let response = response?.films.first else { return }
            self.film = response
            print(response)
            
//            guard let image = self.film.artworkUrl100?.convertUrlImageResolution(width: 100, height: 100) else { return }
//              guard let imageUrl = URL(string: image) else { return }
//            self.posterImageView.kf.setImage(with: imageUrl)
        }
  
    }
    
    private func setupView() {
        view.addSubview(posterImageView)
        view.addSubview(nameLabel)
        
        posterImageView.fillSuperview(padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
}

