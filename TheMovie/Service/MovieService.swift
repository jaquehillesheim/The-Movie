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
    
    func fetchPosterPath(poster: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w185\(poster)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                let image = UIImage(data: data)
                completion(.success(image ?? UIImage()))
            }
        }.resume()
        
    }
}
