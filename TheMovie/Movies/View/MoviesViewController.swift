//
//  ViewController.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 29/10/22.
//

import UIKit
import SnapKit
import SDWebImage

class MoviesViewController: UIViewController {
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tituloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Escolha seu filmes."
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        return label
        
    }()
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = UIColor(red: 250/255, green: 214/255, blue: 165/255, alpha: 1)
        tableview.register(MoviesTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 155/255, green: 161/255, blue: 123/255, alpha: 1)
        button.setTitle("Voltar", for: .normal)
        button.addTarget(self, action: #selector(removepage), for: .touchUpInside)
        return button
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 155/255, green: 161/255, blue: 123/255, alpha: 1)
        button.setTitle("Confirma", for: .normal)
        button.addTarget(self, action: #selector(presentView), for: .touchUpInside)
        return button
    }()
    
    private var viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 64/255, green: 66/255, blue: 48/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        setupView()
        viewModel.loadData()
        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

private extension MoviesViewController {
    func setupView() {
        view.addSubview(headerView)
        headerView.addSubview(tituloLabel)
        view.addSubview(tableView)
        view.addSubview(removeButton)
        view.addSubview(okButton)
        
        setupConstraint()
    }
    
    func setupConstraint() {
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        tituloLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(headerView)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        removeButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        okButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MoviesTableViewCell else { return UITableViewCell() }
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.title.text = cellViewModel.title
        cell.idLabel.text = cellViewModel.id
        cell.posterPathImage.sd_setImage(with: cellViewModel.poster_path)
        cell.originalLinguageLabel.text = cellViewModel.original_language
        return cell
    }
}
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = viewModel.didSelectMovie(at: indexPath)
        let viewController = MovieDetailsViewController(id: id)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

@objc
private extension MoviesViewController {
    func presentView() {
        viewModel.nextPage()
    }
}
@objc
private extension MoviesViewController {
    func removepage() {
        viewModel.previousPage()
    }
}
