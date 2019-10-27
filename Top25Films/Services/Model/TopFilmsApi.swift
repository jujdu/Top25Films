//
//  TopFilmsApi.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 25.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

// MARK: - TopFilmsApi
struct TopFilmsApi: Decodable {
    let topFilms: [TopFilm]
}

// MARK: - TopFilm
struct TopFilm: Decodable {
    let id: String
    
    let name: String
    let artworkUrl100: String
}

// MARK: - Extension of TopFilmsApi to avoid a JSON lvl "feed" above TopFilmsApi
extension TopFilmsApi {
    enum CodingKeys: String, CodingKey {
        case feed
    }
    
    enum TopFilmsApiKeys: String, CodingKey {
        case topFilms = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let feed = try values.nestedContainer(keyedBy: TopFilmsApiKeys.self, forKey: .feed)
        topFilms = try feed.decode([TopFilm].self, forKey: .topFilms)
    }
}
