//
//  NetworkDataFetcher.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 26.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

class NetworkDataFetcher {
    
    let networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func getTopFilms(completion: @escaping (TopFilmsApi?) -> ()) {
        let url = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/25/explicit.json"
        networking.request(url: url, parameters: nil, completion: completion)
    }
    
    func getAFilm(id: String, completion: @escaping (FilmApi?) -> ()) {
        let url = "https://itunes.apple.com/lookup?"
        let parameters = ["id": id]
        networking.request(url: url, parameters: parameters, completion: completion)
    }
    
}
