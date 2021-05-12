//
//  Movie.swift
//  MovieListApp
//
//  Created by David Phan on 4/2/21.
//

import Foundation
import SwiftUI

struct MovieResults: Decodable {
    let page: Int?
    let total_pages: Int?
    let total_results: Int?
    var results: [Movie]
}

struct Movie: Hashable, Decodable, Identifiable {
    var id: Int
    var vote_count: Int
    var vote_average: Double
    var title: String
    var backdrop_path: String
    var poster_path: String
    var release_date: String
    var overview: String
    var genre_ids: [Int]
        
    var backdropURL: URL {
            return URL(string: "https://image.tmdb.org/t/p/w500\(backdrop_path)")!
    }
    
    var posterURL: URL {
            return URL(string: "https://image.tmdb.org/t/p/w500\(poster_path)")!
    }
}


