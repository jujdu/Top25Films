//
//  TopFilmsRouter.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 29.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

protocol TopFilmsRouterProtocol {
    func presentFilmDetailView(for id: String)
}

class TopFilmsRouter: TopFilmsRouterProtocol {
    
    //MARK: - Properties
    private weak var topFilmsViewController: TopFilmsViewController?
    
    //MARK: - Inits
    init(topFilmsViewController: TopFilmsViewController) {
        self.topFilmsViewController = topFilmsViewController
    }
    
    //MARK: - TopFilmsRounter
    func presentFilmDetailView(for id: String) {
        print(id)
        let filmDetailPresenter = FilmDetailPresenter(filmId: id)
        let filmDetailVC = FilmDetailViewController(with: filmDetailPresenter)
        topFilmsViewController?.navigationController?.pushViewController(filmDetailVC, animated: true)
    }
}
