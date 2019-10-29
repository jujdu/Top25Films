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
    var numberOfSections: Int { get }
    func set(cell: FilmDetailCellProtocol, section: Int)
}

class FilmDetailPresenter: FilmDetailPresenterProtocol {
    
    //MARK: - Properties
    private let networkDataFetcher: NetworkDataFetcher
    weak private var view: FilmDetailViewProtocol?
    
    var numberOfSections: Int = 0
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
            
            self.numberOfSections = 3
            self.view?.loadingView(is: false)
            self.view?.refreshView()
        }
    }
    
    func handleUrlString(urlString: String?) -> URL? {
        guard let urlString = urlString else { return nil }
        let convertedUrlString = urlString.convertUrlImageResolution(width: 500, height: 500)
        guard let url = URL(string: convertedUrlString) else { return nil }
        return url
    }
    
    //MARK: - FilmDetailPresenterProtocol
    
    func attachView(view: FilmDetailViewProtocol) {
        self.view = view
        view.loadingView(is: true)
        getData()
    }
    
    func set(cell: FilmDetailCellProtocol, section: Int) {
        switch section {
        case 0:
            let convertedString = film.posterUrl100.convertUrlImageResolution(width: 600, height: 600)
            cell.set(with: convertedString)
        case 1:
            cell.set(with: film.filmName)
        case 2:
            cell.set(with: film.longDescription)
        default:
            print("abc")
        }
    }
}
