//
//  FilmDetailModel.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 13/11/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

// MARK: - Configure Model Item Type and Protocol for Detail Model Items
enum FilmDetailModelItemType {
    case image
    case title
    case plot
    
    func cellForModelItemType(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch self {
        case .image:
            return tableView.dequeueReusableCell(withIdentifier: FilmDetailImageCell.reuseId, for: indexPath) as! FilmDetailImageCell
        case .title, .plot:
            return tableView.dequeueReusableCell(withIdentifier: FilmDetailLabelCell.reuseId, for: indexPath) as! FilmDetailLabelCell  
        }
    }
    
    func configureCellForModelItemType(cell: UITableViewCell, data: FilmDetailModelItemProtocol) {
        switch self {
        case .image:
            let cell = cell as! FilmDetailImageCell
            cell.set(with: data)
        case .title, .plot:
            let cell = cell as! FilmDetailLabelCell
            cell.set(with: data)
        }
    }
}

//MARK: - FilmDetailModelItemProtocol + Extension
protocol FilmDetailModelItemProtocol {
    var type: FilmDetailModelItemType { get }
    var rowsCount: Int { get }
    var sectionTitle: String? { get }
    var sectionHeight: CGFloat { get }
}

extension FilmDetailModelItemProtocol {
    var rowsCount: Int {
        return 1
    }
    var sectionHeight: CGFloat {
        return 30
    }
}

// MARK: - Implementation FilmDetailModelImageItem
class FilmDetailModelImageItem: FilmDetailModelItemProtocol, FilmDetailImageCellProtocol {
    //MARK: FilmDetailModelItemProtocol
    var type: FilmDetailModelItemType = .image
    var sectionTitle: String? = nil
    var sectionHeight: CGFloat = 0
    
    //MARK: FilmDetailImageCellProtocol
    var image: String
    
    init(imageUrl: String) {
        self.image = imageUrl
    }
}

// MARK: - Implementation FilmDetailModelTitleItem
class FilmDetailModelTitleItem: FilmDetailModelItemProtocol, FilmDetailLabelCellProtocol {
    //MARK: FilmDetailModelItemProtocol
    var type: FilmDetailModelItemType = .title
    var sectionTitle: String? = "Title"
    
    //MARK: FilmDetailLabelCellProtocol
    var label: String
    
    init(label: String) {
        self.label = label
    }
}

// MARK: - Implementation FilmDetailModelPlotItem
class FilmDetailModelPlotItem: FilmDetailModelItemProtocol, FilmDetailLabelCellProtocol {
    //MARK: FilmDetailModelItemProtocol
    var type: FilmDetailModelItemType = .plot
    var sectionTitle: String? = "Plot"
    
    //MARK: FilmDetailLabelCellProtocol
    var label: String
    
    init(label: String) {
        self.label = label
    }
}
