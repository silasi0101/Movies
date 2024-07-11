//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Sivamanikandan Silasi on 10/07/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private var movie: Movie?
    
    lazy private var backGroundImageView : UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "movies_Logo"))
        imageview.alpha = 0.6
        imageview.contentMode = .scaleAspectFill
        imageview.frame = self.view.bounds
        return imageview
    }()
    
    lazy private var  blurEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.frame = self.view.frame
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    lazy private var movieImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "movies_Logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.systemPink.cgColor
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 4.0
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy private var favoriteMovieImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.frame = CGRect(x: 20, y: 20, width: 55, height: 50)
        imageView.backgroundColor = .clear
        imageView.tintColor = .red
        return imageView
    }()
    
    lazy private var  titleLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 26)
        label.textColor = UIColor.darkText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy private var  descriptionLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "palatino", size: 24)
        label.textColor = UIColor.darkText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var  genreLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "palatino", size: 24)
        label.textColor = UIColor.darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy private var  ratingLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "palatino", size: 24)
        label.textColor = UIColor.brown
        label.text = "Rating: Not available"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var detailesStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,genreLabel,descriptionLabel,ratingLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
//        stackView.distribution = .fillEqually
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var portrateConstraints = [
        movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 20),
        movieImageView.heightAnchor.constraint(equalToConstant: (view.frame.height / 2) - 40 ),
        movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20) ,
        movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        
        
        detailesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 20),
        detailesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        detailesStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor , constant: 5),
        detailesStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        
    ]
    
    lazy var landscapeConstraints = [
        movieImageView.widthAnchor.constraint(equalToConstant: (view.frame.width / 2) - 40 ),
        movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 20),
        movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        movieImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20) ,
        
        
        detailesStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor , constant: -20),
        detailesStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 20),
        detailesStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        detailesStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20)
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        setupConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.setupConstraints()
        }, completion: nil)
    }
    
    func setupConstraints() {
        if UIDevice.current.orientation.isPortrait {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portrateConstraints)
            
        }
        else {
            NSLayoutConstraint.deactivate(portrateConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
            
        }
    }
    
    private func setupUI() {
        
        view.addSubview(backGroundImageView)
        view.addSubview(blurEffectView)
        
        view.addSubview(movieImageView)
        
        movieImageView.layoutIfNeeded()
        movieImageView.addSubview(favoriteMovieImageView)
        
        view.addSubview(detailesStackView)
        
    }
    
    public func updateDetailOf(movie : Movie? = nil , movieImage : UIImage? = nil) {
        
        guard let movie = movie else { return }
        
        if let image = movieImage {
            DispatchQueue.main.async { [weak self] in
                self?.backGroundImageView.image = image
                self?.movieImageView.image = image
                self?.movieImageView.contentMode = .scaleAspectFill // optionally set
            }
        }
        
        self.title = movie.title
        
        titleLabel.text = movie.title
        
        descriptionLabel.text = "Description: \(movie.title)"
        
        genreLabel.text = "Genre: \(movie.type)"
        
        if !UserDefaults.standard.bool(forKey: movie.title) {
            self.favoriteMovieImageView.isHidden = true
        }
    }
}
