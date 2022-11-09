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
    
    private let viewModel = MovieDetailsViewModel()
    private let id: Int
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 230/255, green: 248/255, blue: 234/255, alpha: 1)
        viewModel.loadData(id: id)
        setupView()
        viewModel.reload = {
            self.setDetails()
        }
    }
}
extension MovieDetailsViewController {
    func setupView() {
        view.addSubview(label)
        view.addSubview(backdropPathImage)
        view.addSubview(titleLabel)
        view.addSubview(adultLabel)
        view.addSubview(releaseDateLabel)
        
        setupContraint()
        
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
    
    func setDetails() {
        DispatchQueue.main.async {
            
            self.titleLabel.text = self.viewModel.title
            self.releaseDateLabel.text = self.viewModel.releaseDate
        }
        
    }
}

