//
//  MovieService.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 29/10/22.
//

import Foundation
import UIKit

class MovieService {
    private let urlAPI = "https://api.themoviedb.org/3/trending/all/week?api_key="
    private let token = "4c952a66aec922c199eb9a89786edb85"
    private let language = "&language=pt-BR"
    
    func fetchMovies(page: Int, completion: @escaping (Result<MoviesModel, Error>) -> Void) {
        guard let url = URL(string: "\(urlAPI)\(token)\(language)&page=\(page)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            do {
                let movies = try JSONDecoder().decode(MoviesModel.self, from: data!)
                completion(.success(movies))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchMovieDetails(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(token)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            do {
                let movies = try JSONDecoder().decode(Movie.self, from: data!)
                completion(.success(movies))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
