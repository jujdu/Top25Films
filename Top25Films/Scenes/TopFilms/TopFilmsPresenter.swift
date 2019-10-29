//
//  TopFilmsPresenter.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 29.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

protocol TopFilmsPresenterProtocol {
    func attachView(view: TopFilmsViewProtocol)
    var numberOfFilms: Int { get }
    func set(cell: TopFilmsCell, row: Int)
    func didSelect(row: Int)
}

class TopFilmsPresenter: TopFilmsPresenterProtocol {
    
    //MARK: - Properties
    private let networkDataFetcher: NetworkDataFetcher
    let router: TopFilmsRouterProtocol?
    weak private var view: TopFilmsViewProtocol?
    
    var topFilms: [TopFilm] = []
    var numberOfFilms: Int {
        return topFilms.count
    }
    
    //MARK: - Inits
    init(networkDataFetcher: NetworkDataFetcher = NetworkDataFetcher(), router: TopFilmsRouterProtocol?) {
        self.networkDataFetcher = networkDataFetcher
        self.router = router
    }
    
    //MARK: - User functions
    private func getData() {
        networkDataFetcher.getTopFilms { [unowned self] (topFilmsApi) in
            guard let topFilmsApi = topFilmsApi else { return }
            self.topFilms = topFilmsApi.topFilms
            self.view?.loadingView(is: false)
            self.view?.refreshView()
        }
    }
    
    //MARK: - TopFilmsPresenterProtocol
    func attachView(view: TopFilmsViewProtocol) {
        self.view = view
        view.loadingView(is: true)
        getData()
    }
    
    func set(cell: TopFilmsCell, row: Int) {
        let film = topFilms[row]
        cell.set(film: film)
    }
    
    func didSelect(row: Int) {
        let filmId = topFilms[row].id
        print("Presenter send",filmId)
        router?.presentFilmDetailView(for: filmId)
    }
}
