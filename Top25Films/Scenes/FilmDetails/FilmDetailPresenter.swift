//
//  FilmDetailPresenter.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 29.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

protocol FilmDetailPresenterProtocol {
    func attachView(view: FilmDetailViewProtocol)
    //    func set(cell: TopFilmsCell, row: Int)
}

class FilmDetailPresenter: FilmDetailPresenterProtocol {
    
    //MARK: - Properties
    private let networkDataFetcher: NetworkDataFetcher
    weak private var view: FilmDetailViewProtocol?
    
    private var filmId: String!
    private var film: Film!
    
    //MARK: - Inits
    init(networkDataFetcher: NetworkDataFetcher = NetworkDataFetcher(), filmId: String) {
        self.networkDataFetcher = networkDataFetcher
        self.filmId = filmId
    }
    
    //MARK: - User functions
    private func getData() {
        networkDataFetcher.getAFilm(id: filmId) { [weak self] (filmApi) in
            guard let filmApi = filmApi else { return }
            guard let self = self else { return }
            self.film = filmApi.films.first
            
            let imageUrl = self.handleUrlString(urlString: self.film.posterUrl100)
            self.view?.refreshView(name: self.film.filmName,
                                   plot: self.film.longDescription,
                                   imageUrl: imageUrl)
            self.view?.loadingView(is: false)
        }
    }
    
    func attachView(view: FilmDetailViewProtocol) {
        self.view = view
        view.loadingView(is: true)
        getData()
    }
    
    func handleUrlString(urlString: String?) -> URL? {
        guard let urlString = urlString else { return nil }
        let convertedUrlString = urlString.convertUrlImageResolution(width: 500, height: 500)
        guard let url = URL(string: convertedUrlString) else { return nil }
        return url
    }    
}
