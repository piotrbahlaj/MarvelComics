//
//  SearchView.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 28/08/2024.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    var filteredComics: [Comic] {
        return viewModel.searchedComics.filter{
            $0.title.localizedCaseInsensitiveContains(viewModel.query)
        }
    }
    var body: some View {
        NavigationStack{
            if viewModel.query != "" {
                List(filteredComics, id: \.id) {comic in
                    ComicView(comic: comic)
                }
            } else {
                Text("Try searching for something")
                    .font(.body)
                    .padding()
                    .navigationTitle("Library")
            }
        }
        .searchable(text: $viewModel.query, prompt: "Search for comics")
    }   
}
