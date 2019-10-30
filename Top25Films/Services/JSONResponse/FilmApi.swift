//
//  FilmResponse.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 25.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

// MARK: - FilmResponse
struct FilmApi: Decodable {
    let films: [Film]
    
    enum CodingKeys: String, CodingKey {
        case films = "results"
    }
}

// MARK: - Result
struct Film: Decodable {
    let filmName: String
    let longDescription: String
    let posterUrl100: String
    
    enum CodingKeys: String, CodingKey {
        case filmName = "trackName"
        case posterUrl100 = "artworkUrl100"
        case longDescription
    }
}
