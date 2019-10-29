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
}

class TopFilmsPresenter: TopFilmsPresenterProtocol {
    
    private let networkDataFetcher: NetworkDataFetcher
    weak private var view: TopFilmsViewProtocol?
    
    init(networkDataFetcher: NetworkDataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func attachView(view: TopFilmsViewProtocol) {
        self.view = view
        populateData()
    }
    
    func populateData() {
        networkDataFetcher.getTopFilms { [unowned self] (topFilmsApi) in
            guard let topFilmsApi = topFilmsApi else { return }
            self.view?.topFilms = topFilmsApi.topFilms
        }
    }
}
