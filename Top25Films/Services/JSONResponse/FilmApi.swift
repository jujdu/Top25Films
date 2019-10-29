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
    let directorName: String
    let filmName: String
    let country: String
    let longDescription: String
    let shortDescription: String
    let posterUrl100: String
    
    enum CodingKeys: String, CodingKey {
        case directorName = "artistName"
        case filmName = "trackName"
        case country
        case longDescription
        case shortDescription
        case posterUrl100 = "artworkUrl100"
    }
}
