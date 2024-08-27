//
//  ContentView.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 26/08/2024.
//

import SwiftUI
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    var body: some View {
        NavigationView{
            VStack{
                if viewModel.isLoading{
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundStyle(.red)
                } else {
                    List(viewModel.comics) { comic in
                        ComicView(comic: comic)
                    }
                    
                }
            }
            .navigationTitle("Marvel Comics")
            .onAppear{
                viewModel.fetchComics()
            }
        }
    }
}
    #Preview {
        HomeView()
    }

