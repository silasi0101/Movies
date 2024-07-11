//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Sivamanikandan Silasi on 10/07/24.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    private var viewModel = MoviesViewModel()
    
    lazy private var dataActivityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.tintColor = .blue
        indicator.center = self.view.center
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy private var movieSearchBar : UISearchBar  = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search Movies"
        return searchBar
    }()
    
    lazy private var MoviesListTableView : UITableView  = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy private var  searchResultLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "chalkboard se", size: 17)
        label.textColor = UIColor.brown
        label.numberOfLines = 0
        return label
    }()
    
    private var moviesNameKeyWordList = ["Don" , "Inter" , "Raise"]
    
    private func randomMovieKeyWord() -> String {
        return moviesNameKeyWordList.randomElement() ?? "Don"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        viewModel.fetchMoviesWith(name: randomMovieKeyWord())
    }
    
    private func setupUI() {
        view.addSubview(MoviesListTableView)
        
        navigationItem.titleView = movieSearchBar
        
        NSLayoutConstraint.activate([
            MoviesListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            MoviesListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            MoviesListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 10),
            MoviesListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -10)
        ])
        
        
        MoviesListTableView.addSubview(searchResultLabel)
        NSLayoutConstraint.activate([searchResultLabel.centerXAnchor.constraint(equalTo: MoviesListTableView.centerXAnchor),
            searchResultLabel.centerYAnchor.constraint(equalTo:MoviesListTableView.centerYAnchor),searchResultLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5)])
        
        self.view.addSubview(dataActivityIndicator)
        dataActivityIndicator.startAnimating()
    }
    
    private func bindViewModel() {
        viewModel.didUpdateMovies = {
            DispatchQueue.main.async { [weak self] in
                self?.MoviesListTableView.reloadData()
                self?.dataActivityIndicator.stopAnimating()
                
            }
        }
        
        viewModel.didFailWithError = { error in
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
}

extension MoviesListViewController : UITableViewDataSource ,  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        let movie = viewModel.filteredMovies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.filteredMovies[indexPath.row]
        let detailsVC = MovieDetailsViewController()
        
        if let selectedCell = tableView.cellForRow(at: indexPath) as? MovieTableViewCell  {
            detailsVC.updateDetailOf(movie: movie, movieImage: selectedCell.posterImageView.image)
        }
        else {
            detailsVC.updateDetailOf(movie: movie)
        }
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension MoviesListViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterMovies(by: searchText) {
            DispatchQueue.main.async {[weak self] in
                self?.searchResultLabel.isHidden = false
                self?.searchResultLabel.text = "No Movies With the name '\(searchText)' try Other Names"
            }
        }
        searchResultLabel.isHidden = true
        MoviesListTableView.reloadData()
    }
}

