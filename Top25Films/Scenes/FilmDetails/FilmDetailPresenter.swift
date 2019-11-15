//
//  FilmDetailPresenter.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 29.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

protocol FilmDetailPresenterProtocol {
    func attachView(view: FilmDetailViewProtocol)
}

class FilmDetailPresenter: FilmDetailPresenterProtocol {
    
    //MARK: - Properties
    private let networkDataFetcher: NetworkDataFetcher
    weak private var view: FilmDetailViewProtocol?
    private var filmId: String!
    
    //MARK: - Inits
    init(networkDataFetcher: NetworkDataFetcher = NetworkDataFetcher(), filmId: String) {
        self.networkDataFetcher = networkDataFetcher
        self.filmId = filmId
    }
    
    //MARK: - User functions
    private func getData() {
        networkDataFetcher.getAFilm(id: filmId) { [weak self] (filmApi) in
            guard let film = filmApi?.films.first else { return }
            guard let self = self else { return }
            
            let imageSection = FilmDetailModelImageItem(imageUrl: film.posterUrl100.convertUrlImageResolution(width: 500, height: 500))
            let titleSection = FilmDetailModelTitleItem(label: film.filmName)
            let plotSection = FilmDetailModelPlotItem(label: film.longDescription)
            
            self.view?.viewModel.append(imageSection)
            self.view?.viewModel.append(titleSection)  
            self.view?.viewModel.append(plotSection)

            self.view?.loadingView(is: false)
            self.view?.refreshView()
        }
    }

    //MARK: - FilmDetailPresenterProtocol
    
    func attachView(view: FilmDetailViewProtocol) {
        self.view = view
        view.loadingView(is: true)
        getData()
    }
}
