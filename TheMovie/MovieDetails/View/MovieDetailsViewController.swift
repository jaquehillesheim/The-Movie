//
//  YellowViewController.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 29/10/22.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class MovieDetailsViewController: UIViewController {

    private lazy var backdropPathImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 32.0
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.numberOfLines = 4
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var userScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
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
        view.setBackground()
        viewModel.loadData(id: id)
        setupView()
        viewModel.reload = {
            self.setDetails()
        }
    }
}
extension MovieDetailsViewController {
    func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(backdropPathImage)
        view.addSubview(userScoreLabel)
        view.addSubview(descriptionLabel)
        setupContraint()
    }
    
    func setupContraint() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32.0)
            make.leading.trailing.equalToSuperview()
        }
        backdropPathImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.leading.trailing.equalToSuperview()
            make.size.equalTo(250)
            make.top.equalTo(titleLabel.snp.bottom).offset(32.0)
        }
        userScoreLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropPathImage.snp.bottom).offset(32.0)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(userScoreLabel.snp.bottom).offset(32.0)
            make.leading.trailing.equalToSuperview().inset(16.0)
        }
    }
    
    func setDetails() {
        DispatchQueue.main.async {
            
            self.titleLabel.text = self.viewModel.title
            self.backdropPathImage.sd_setImage(with: self.viewModel.backdropPathImage)
            self.userScoreLabel.text = self.viewModel.userScoreLabel
            self.descriptionLabel.text = self.viewModel.descriptionLabel
        }
    }
}

