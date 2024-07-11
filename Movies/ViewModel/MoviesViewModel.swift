//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Sivamanikandan Silasi on 10/07/24.
//

import Foundation

class MoviesViewModel {
    
    private let apiKey = "c178fd1b"
    private let baseUrl = "https://www.omdbapi.com/"
    
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    
    var didUpdateMovies: (() -> Void)?
    var didFailWithError: ((Error) -> Void)?
    
    func fetchMoviesWith(name: String) {
        let urlString = "\(baseUrl)?apikey=\(apiKey)&type=movie&s=\(name)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.didFailWithError?(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                self.movies = movieResponse.search
                self.filteredMovies = self.movies
                self.didUpdateMovies?()
            } catch {
                self.didFailWithError?(error)
            }
        }
        task.resume()
    }
    
    func filterMovies(by searchText: String , invalidTextHandler : (() -> Void)) {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        if filteredMovies.isEmpty {
            invalidTextHandler()
        }
    }
}

