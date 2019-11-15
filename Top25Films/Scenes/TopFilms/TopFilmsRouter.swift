//
//  TopFilmsRouter.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 29.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

protocol TopFilmsRouterProtocol: class {
    func presentFilmDetailView(for id: String)
}

class TopFilmsRouter: TopFilmsRouterProtocol {
    
    //MARK: - Properties
    weak var viewController: TopFilmsViewController?
    
    //MARK: - TopFilmsRounter
    func presentFilmDetailView(for id: String) {
        let filmDetailPresenter = FilmDetailPresenter(filmId: id)
        let filmDetailVC = FilmDetailViewController(with: filmDetailPresenter)
        viewController?.navigationController?.pushViewController(filmDetailVC, animated: true)
    }
}
