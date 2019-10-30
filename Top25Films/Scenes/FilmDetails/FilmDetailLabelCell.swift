//
//  FilmDetailLabelCell.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 29.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit
import Kingfisher

class FilmDetailLabelCell: UITableViewCell, FilmDetailCellProtocol {
    
    //MARK: - Properties
    static let reuseId = "FilmDetailLabelCell"
    
    //MARK: - UIViews
    
    let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.2621140456, green: 0.2647092342, blue: 0.2647092342, alpha: 1)
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
    
    //MARK: - User functions
    func set(with string: String) {
        nameLabel.text = string
    }
    
    private func setupConstaints() {
        addSubview(cellView)
        cellView.fillSuperview()

        cellView.addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
                         size: .zero)
    }
}
