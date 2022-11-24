//
//  MainViewModel.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 06/11/22.
//

import Foundation
import UIKit

class MoviesViewModel {
    
    var movies: MoviesModel?
    var reloadTableView: (() -> Void)?
    var alert: (() -> Void)?
    
    private let service = MovieService()
    private var page: Int = 1
    
    private var cellViewModels: [MoviesCellViewModel] = [MoviesCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    func loadData() {
        service.fetchMovies(page: page) { result in
            switch result {
            case .success(let movies):
                self.createCell(movies: movies)
                self.reloadTableView?()
            case .failure:
                self.alert?()
            }
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> MoviesCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(movies: MoviesModel) {
        self.movies = movies
        var viewModels = [MoviesCellViewModel]()
        for movie in movies.results {
            guard let urlImage = URL(string: "https://image.tmdb.org/t/p/w185\(movie.poster_path ?? "")") else { return }
            
            let title = configureTitle(movie: movie)
            let releaseDate = configureDate(movie: movie)

            viewModels.append(
                MoviesCellViewModel(
                    title: title,
                    poster_path: urlImage,
                    release_date: releaseDate
                )
            )
            
            cellViewModels = viewModels
        }
    }
    
    func didSelectMovie(at indexPath: IndexPath) -> Int {
        return self.movies?.results[indexPath.row].id ?? 0
    }
}

private extension MoviesViewModel {
    func configureTitle(movie: Movie) -> String {
        var title: String = ""
        
        if let movieTitle = movie.title {
            title = movieTitle
        }
        
        if let movieName = movie.name {
            title = movieName
        }
        return title
    }
    
    func configureDate(movie: Movie) -> String {
        var releaseData: String = ""
        
        if let date = movie.release_date {
            releaseData = date
        }
        
        if let date = movie.first_air_date {
            releaseData = date
        }
        return "Lançamento: \(releaseData.formatDate())"
    }
}

struct MoviesCellViewModel {
    let title: String
    let poster_path: URL
    let release_date: String
}
