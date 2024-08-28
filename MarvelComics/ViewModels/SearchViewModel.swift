//
//  SearchViewModel.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 28/08/2024.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject{
    @Published var searchedComics: [Comic] = []
    @Published var query: String = ""    
}
