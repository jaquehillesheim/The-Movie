//
//  MainTableViewCell.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 29/10/22.
//

import Foundation
import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {

    private(set) lazy var posterPathImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private(set) lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 4
        label.textColor = .red
        return label
    }()
    
    private(set) lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var originalLinguageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var voteCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var voteAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        backgroundColor = UIColor(red: 250/255, green: 214/255, blue: 165/255, alpha: 1)
        
        addSubview(title)
        addSubview(idLabel)
        addSubview(originalLinguageLabel)
        addSubview(voteAverageLabel)
        addSubview(posterPathImage)
        addSubview(voteCountLabel)
        addSubview(popularityLabel)
        
        posterPathImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(150)
            make.bottom.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(posterPathImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.equalTo(posterPathImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        originalLinguageLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(5)
            make.leading.equalTo(posterPathImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        voteCountLabel.snp.makeConstraints { make in
            make.top.equalTo(originalLinguageLabel.snp.bottom).offset(5)
            make.leading.equalTo(posterPathImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        voteAverageLabel.snp.makeConstraints { make in
            make.top.equalTo(voteCountLabel.snp.bottom).offset(5)
            make.leading.equalTo(posterPathImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        popularityLabel.snp.makeConstraints { make in
            make.top.equalTo(voteAverageLabel.snp.bottom).offset(5)
            make.leading.equalTo(posterPathImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
