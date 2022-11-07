//
//  MainViewModel.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 06/11/22.
//

import Foundation
import UIKit

class MainViewModel {
    
    var movies: MoviesModel?
    var reloadTableView: (() -> Void)?
    
    private let service = MovieService()
    private var page: Int = 1
    
    private var cellViewModels: [MainCellViewModel] = [MainCellViewModel]() {
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
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> MainCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(movies: MoviesModel) {
        self.movies = movies
        var viewModels = [MainCellViewModel]()
        for movie in movies.results {
            guard let urlImage = URL(string: "https://image.tmdb.org/t/p/w185\(movie.poster_path ?? "")") else { return }
            let id = "id: \(movie.id)"
            let language = "Idioma: \(movie.original_language ?? "") "
            if let title = movie.title {
                viewModels.append(MainCellViewModel(title: title, id: id, poster_path: urlImage, original_language: language))
            }
            if let name = movie.name {
                viewModels.append(MainCellViewModel(title: name, id: id, poster_path: urlImage, original_language: language))
            }
            cellViewModels = viewModels
        }
    }
    
    func nextPage() {
        page += 1
        loadData()
        reloadTableView?()
    }
    
    func previousPage() {
        page -= 1
        loadData()
        reloadTableView?()
    }
}

struct MainCellViewModel {
    let title: String
    let id: String
    let poster_path: URL
    let original_language: String?
}
