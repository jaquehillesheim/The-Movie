//
//  MovieModel.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 29/10/22.
//

import Foundation

struct MoviesModel: Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let title: String?
    let name: String?
    let id: Int
    let original_language: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double
    let vote_count: Int
    let popularity: Float
    let adult: Bool
    let release_date: String?
    let first_air_date: String?
}
