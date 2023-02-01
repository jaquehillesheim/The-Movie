//
//  ViewController.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 29/10/22.
//

import UIKit
import SnapKit
import SDWebImage
import Lottie

class MoviesViewController: UIViewController {
    
    private lazy var tituloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Escolha seu filmes."
        label.textColor = .white
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(MoviesTableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.backgroundColor = .clear
        tableview.separatorStyle = .none
        
        return tableview
    }()
    
    private let animationView: LottieAnimationView = {
        let lottieAnimationView = LottieAnimationView(name: "Movie")
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        lottieAnimationView.loopMode = .repeat(2.0)
        lottieAnimationView.backgroundColor = .clear
        
        return lottieAnimationView
    }()
    
    private var viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackground()
        setupView()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.loadData()
        viewModel.reloadTableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.alert = {
            DispatchQueue.main.async {
                self.alert(title: "Atenção", message: "Não foi possivel carregar o filme")
                }
            }
        navigationController?.navigationBar.tintColor = .white
    }
}

private extension MoviesViewController {
    
    func setupLottie() {
        view.addSubview(animationView)
        
        animationView.frame = view.bounds
        animationView.center = view.center
        animationView.alpha = 1
        animationView.backgroundColor = .darkBackground
        
        animationView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        animationView.play { _ in
            UIView.animate(withDuration: 2, animations: {
            self.animationView.alpha = 0
          }, completion: { _ in
            self.viewModel.loadData()
            self.animationView.isHidden = true
            self.animationView.removeFromSuperview()
           
          })
        }
    }
    func setupView() {
        navigationItem.backButtonTitle = "Voltar"
        view.addSubview(tituloLabel)
        view.addSubview(tableView)
        setupConstraint()
        setupLottie()
    }
    
    func setupConstraint() {
        
        tituloLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tituloLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(
            title: "Tente Novamente",
            style: .default,
            handler: { _ in
                self.viewModel.loadData()
                
            })
        alert.addAction(defaultAction)
        self.present(alert, animated: true)
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
        cell.posterPathImage.sd_setImage(with: cellViewModel.poster_path)
        cell.releaseDataLabel.text = cellViewModel.release_date
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
