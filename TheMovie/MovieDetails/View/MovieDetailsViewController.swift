//
//  YellowViewController.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 29/10/22.
//

import Foundation
import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController {
    
    private lazy var backdropPathImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 20
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var adultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 230/255, green: 248/255, blue: 234/255, alpha: 1)
    }
}
extension MovieDetailsViewController {
    func setupView(movie: Movie) {
        view.addSubview(label)
        view.addSubview(backdropPathImage)
        view.addSubview(titleLabel)
        view.addSubview(adultLabel)
        view.addSubview(releaseDateLabel)
        
        setupContraint()
        
        releaseDateLabel.text = "Lançamento do Filme: \(movie.release_date ?? "")"
        
        adultLabel.text = "Adult: \(movie.adult)"
        
        guard movie.backdrop_path != nil else {
            return
        }
        label.text = movie.overview
        
//        let backdropImage = "https://image.tmdb.org/t/p/w185\(image)"
//        backdropPathImage.loadFrom(URLAddress: backdropImage)
        
        guard let movieTitle = movie.title else {
            titleLabel.text = "\(movie.name ?? "")"
            return
        }
        titleLabel.text = "\(movieTitle)"
    }
    
    func setupContraint() {
        backdropPathImage.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.width.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropPathImage.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        adultLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(adultLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
