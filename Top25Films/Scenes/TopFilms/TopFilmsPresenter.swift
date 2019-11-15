//
//  TopFilmsPresenter.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 29.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

protocol TopFilmsPresenterProtocol: class {
    var numberOfFilms: Int { get }
    func set(cell: TopFilmsCell, row: Int)
    func didSelect(row: Int)
    func getData()
}

class TopFilmsPresenter: TopFilmsPresenterProtocol {

    //MARK: - Properties
    private let networkDataFetcher: NetworkDataFetcher
    var router: TopFilmsRouterProtocol?
    weak var view: TopFilmsViewProtocol?
    
    var topFilms: [TopFilm] = []
    var numberOfFilms: Int {
        return topFilms.count
    }
    
    //MARK: - Inits
    init(networkDataFetcher: NetworkDataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    //MARK: - User functions
    func getData() {
        view?.loadingView(is: true)
        networkDataFetcher.getTopFilms { [unowned self] (topFilmsApi) in
            guard let topFilmsApi = topFilmsApi else { return }
            self.topFilms = topFilmsApi.topFilms
            self.view?.loadingView(is: false)
            self.view?.refreshView()
        }
    }
    
    //MARK: - TopFilmsPresenterProtocol
    func set(cell: TopFilmsCell, row: Int) {
        let film = topFilms[row]
        cell.set(film: film)
    }
    
    func didSelect(row: Int) {
        let filmId = topFilms[row].id
        router?.presentFilmDetailView(for: filmId)
    }
}


