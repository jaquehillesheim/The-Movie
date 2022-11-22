//
//  MainTableViewCell.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 29/10/22.
//

import Foundation
import UIKit
import SnapKit

class MoviesTableViewCell: UITableViewCell {

    private(set) lazy var posterPathImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 32.0
        image.layer.masksToBounds = true
        return image
    }()
    
    private(set) lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        [title, releaseDataLabel].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fillProportionally
        stack.spacing = 8
        return stack
    }()
    
    private(set) lazy var releaseDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        [posterPathImage, textStackView].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fillProportionally
        stack.spacing = 16.0
        stack.alignment = .center
        return stack
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setupLabel()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.0)
            make.bottom.equalToSuperview().offset(-16.0)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        posterPathImage.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(120)
        }
        
        posterPathImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(150)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setLayout() {
        backgroundColor = .clear
    }
}
