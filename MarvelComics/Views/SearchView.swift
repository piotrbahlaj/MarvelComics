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
            VStack{
                if viewModel.isLoading {
                    ProgressView("Searching...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundStyle(.red)
                } else if !viewModel.searchedComics.isEmpty {
                    List(filteredComics, id: \.id) { comic in
                        ComicView(comic: comic)
                    }
                } else if viewModel.query.isEmpty {
                    Text("Try searching for something" )
                        .font(.body)
                        .padding()
                }
            }
            .searchable(text: $viewModel.query, prompt: "Search for comics")
            .navigationTitle("Comic library")
        }
    }
}
