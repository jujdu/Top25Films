//
//  FilmDetailPosterCell.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 29.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import Kingfisher

protocol FilmDetailCellProtocol {
    func set(with viewModel: FilmDetailModelItemProtocol)
}

protocol FilmDetailImageCellProtocol {
    var image: String { get }
}

class FilmDetailImageCell: UITableViewCell, FilmDetailCellProtocol {
    
    //MARK: - Properties
    static let reuseId = "FilmDetailImageCell"
    
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
    
    //MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstaints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - User functions
    func set(with viewModel: FilmDetailModelItemProtocol) {
        guard let viewModel = viewModel as? FilmDetailImageCellProtocol,
              let imageUrl = URL(string: viewModel.image) else { return }
        posterImageView.setImage(imageUrl: imageUrl)
    }
    
    private func setupConstaints() {
        addSubview(cellView)
        cellView.fillSuperview()

        cellView.addSubview(posterImageView)
        
        posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        let posterImageViewBottomAnchor = posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        posterImageViewBottomAnchor.priority = UILayoutPriority(rawValue: 750)
        posterImageViewBottomAnchor.isActive = true
        posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5).isActive = true
    }
}
