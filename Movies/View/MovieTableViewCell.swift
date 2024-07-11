//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Sivamanikandan Silasi on 10/07/24.
//

import UIKit


class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    
     lazy private var titleLabel : UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "copperplate", size: 17)
        return label
    }()
    
     lazy private var releaseDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "symbol", size: 17)
        return label
    }()
    
    lazy var  posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.7
        imageView.image = UIImage(named: "movies_Logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemPink.cgColor
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy private var favoriteButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Unfavorite", for: .normal)
        button.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.titleLabel?.font = UIFont(name: "palatino", size: 15)
        return button
    }()
    
    var isFavorite = false {
        didSet {
            favoriteButton.setTitle(isFavorite ? "Favorite" : "Unfavorite", for: .normal)
            let image = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
            favoriteButton.setImage(image, for: .normal)
            favoriteButton.tintColor = isFavorite ? .systemRed : .systemBlue
            favoriteButton.setTitleColor(isFavorite ? .white : .systemBlue, for: .normal)
        }
    }
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                titleLabel.text = movie.title
                releaseDateLabel.text = "Release Date: \(movie.year)"
                // get Movie image from URL
                if let url = URL(string: movie.poster) {
                    URLSession.shared.dataTask(with: url) { data, _, error in
                        guard error == nil else {
                            print("Image Data Error \(error.debugDescription)")
                            return
                        }
                        if let data = data {
                            DispatchQueue.main.async { [weak self] in
                                self?.posterImageView.image = UIImage(data: data)
                                self?.posterImageView.contentMode = .scaleAspectFill
                                self?.posterImageView.alpha = 1
                            }
                        }
                    }.resume()
                }
                isFavorite = UserDefaults.standard.bool(forKey: movie.title)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -20),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 10),
            posterImageView.widthAnchor.constraint(equalToConstant: 150),
            
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 50),
            
            releaseDateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 10)
        ])
    }
    
    @objc private func toggleFavorite() {
        isFavorite.toggle()
        if let movie = movie {
            UserDefaults.standard.set(isFavorite, forKey: movie.title)
        }
    }
    
    public func configure(with movie: Movie) {
        self.movie = movie
    }
}

