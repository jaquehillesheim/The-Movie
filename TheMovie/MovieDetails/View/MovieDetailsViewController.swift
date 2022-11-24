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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var userScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 26.0, weight: .bold)
        label.textColor = .white
        label.textAlignment = .justified
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
        
        viewModel.reload = {
            DispatchQueue.main.async {
                self.setupView()
                self.setDetails()
            }
        }
        viewModel.alert = {
            self.alert(title: "Atenção", message: "Não foi possivel carregar o detalhe do filme")
            }
        }
    }

extension MovieDetailsViewController {
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(backdropPathImage)
        contentView.addSubview(userScoreLabel)
        contentView.addSubview(descriptionLabel)
        
        
        setupContraint()
    }
    
    func setupContraint() {
        
        contentView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.width.equalTo(scrollView.snp.width)
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        scrollView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        backdropPathImage.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.leading.trailing.equalToSuperview()
            make.size.equalTo(250)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        userScoreLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropPathImage.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(userScoreLabel.snp.bottom).offset(32.0)
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.bottom.equalTo(contentView.snp.bottom)
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
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(
            title: "Voltar",
            style: .default,
            handler: { _ in
                self.navigationController?.popViewController(animated: true)
            })
        alert.addAction(defaultAction)
        present(alert, animated: true)
    }
}

