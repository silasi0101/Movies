//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Sivamanikandan Silasi on 10/07/24.
//

import XCTest
@testable import Movies

final class MoviesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
//    var viewModel: MoviesViewModel!
//    
//    override func setUp() {
//        super.setUp()
//        viewModel = MoviesViewModel()
//    }
//    
//    override func tearDown() {
//        viewModel = nil
//        super.tearDown()
//    }
//    
//    func testFetchMoviesSuccess() {
//        let expectation = self.expectation(description: "FetchMovies")
//        
//        viewModel.didUpdateMovies = {
//            XCTAssertFalse(self.viewModel.movies.isEmpty, "Movies should not be empty")
//            XCTAssertEqual(self.viewModel.movies.count, 10, "Movies count should be 10")
//            expectation.fulfill()
//        }
//        
//        viewModel.didFailWithError = { error in
//            XCTFail("Error should not be called: \(error.localizedDescription)")
//        }
//        let mockData = """
//            {
//                "Search": [
//                    {"Title": "Movie1", "Year": "2001", "imdbID": "tt1234567", "Type": "movie", "Poster": "N/A"},
//                    {"Title": "Movie2", "Year": "2015", "imdbID": "tt1234568", "Type": "movie", "Poster": "N/A"},
//                    {"Title": "Movie3", "Year": "2019", "imdbID": "tt1234569", "Type": "movie", "Poster": "N/A"},
//                    {"Title": "Movie4", "Year": "2019", "imdbID": "tt1234570", "Type": "movie", "Poster": "N/A"},
//                    {"Title": "Movie5", "Year": "2021", "imdbID": "tt1234571", "Type": "movie", "Poster": "N/A"},
//                ]
//            }
//            """.data(using: .utf8)!
//        
//        viewModel.fetchMoviesWith(name: "movie")
//        
//        waitForExpectations(timeout: 5, handler: nil)
//    }
//    
//    func testFetchMoviesFailure() {
//        let expectation = self.expectation(description: "FetchMoviesFailure")
//        
//        viewModel.didFailWithError = { error in
//            XCTAssertNotNil(error, "Error should be present")
//            expectation.fulfill()
//        }
//        
//        viewModel.fetchMoviesWith(name: "don")
//        
//        
//    }
//    
//    func testFilterMovies() {
//        viewModel.movies = [
//            Movie(title: "sky far", year: "2021", imdbID: "tt1234567", type: "movie", poster: "N/A"),
//            Movie(title: "day light", year: "2021", imdbID: "tt1234568", type: "movie", poster: "N/A")
//        ]
//        
//        viewModel.filterMovies(by: "sky", invalidTextHandler: {})
//        XCTAssertEqual(viewModel.filteredMovies.count, 1, "Filtered movies count should be 1")
//        
//        viewModel.filterMovies(by: "day", invalidTextHandler: {})
//        XCTAssertEqual(viewModel.filteredMovies.count, 1, "Filtered movies count should be 1")
//        
//    }
    
}
