//
//  TopFilmsCell.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 25.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

class TopFilmsCell: UITableViewCell {
    
    //MARK: - Properties
    static let reuseId = "TopFilmsCell"
    
    //MARK: - UIViews
    let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "name"
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstaints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
    }
    
    //MARK: - User functions
    func set(film: TopFilm) {
        guard let url = URL(string: film.artworkUrl100) else { return }
        posterImageView.kf.setImage(with: url)
        
        nameLabel.text = film.name
    }
    
    private func setupConstaints() {
        addSubview(cellView)
        cellView.fillSuperview()

        cellView.addSubview(posterImageView)
        cellView.addSubview(nameLabel)
        
        posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        let posterImageViewBottomAnchor = posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        posterImageViewBottomAnchor.priority = UILayoutPriority(rawValue: 750)
        posterImageViewBottomAnchor.isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
