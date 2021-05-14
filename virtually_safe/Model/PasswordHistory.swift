//
//  Movie.swift
//  MovieListApp
//
//  Created by David Phan on 4/2/21.
//

import Foundation
import SwiftUI

class PasswordHistory : ObservableObject {
    @Published var passwords = [String]()
    @Published var dates = [String]()
}

