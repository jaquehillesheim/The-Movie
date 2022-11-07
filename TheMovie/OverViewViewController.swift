//
//  YellowViewController.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 29/10/22.
//

import Foundation
import UIKit
import SnapKit

class YellowViewController: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow

    }
}
extension YellowViewController {
    func setupView(movie: Movie) {
        view.addSubview(label)
        view.addSubview(backdropPathImage)
        view.addSubview(titleLabel)
        
        
        
        setupContraint()
        
        guard let image = movie.backdrop_path else {
            return
        }
        let backdropImage = "https://image.tmdb.org/t/p/w185\(image)"
        backdropPathImage.loadFrom(URLAddress: backdropImage)
        
        guard let movieTitle = movie.title else {
            titleLabel.text = "\(movie.name ?? "")"
            return
        }
        titleLabel.text = "\(movieTitle)"
        
        label.text = movie.overview
    }
    
    func setupContraint() {
        backdropPathImage.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropPathImage.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}