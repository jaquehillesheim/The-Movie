//
//  MovieDetailsViewModel.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 07/11/22.
//

import Foundation
import SDWebImage

class MovieDetailsViewModel {
    private let service = MovieService()
    var model: Movie?
    var reload: (() -> Void)?
    
    func loadData(id: Int) {
        service.fetchMovieDetails(id: id) { result in
            switch result {
            case .success(let success):
                self.model = success
                self.reload?()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    var title: String {
        model?.title ?? ""
    }
    
    var releaseDate: String {
        model?.release_date ?? ""
    }
    
    var backdropPathImage: URL? {
        URL(string: "https://image.tmdb.org/t/p/w185\(model?.backdrop_path ?? "")")
    }
    
    var userScoreLabel: String {
        guard let average = model?.vote_average else { return ""}
        return "Nota dos Usuários: \(average)"
    }
    
    var descriptionLabel: String {
        model?.overview ?? ""
    }
}

