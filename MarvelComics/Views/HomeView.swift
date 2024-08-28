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
        TabView{
            NavigationView{
                VStack{
                    if viewModel.isLoading{
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle())
                    } else if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundStyle(.red)
                    } else {
                        List(viewModel.comics.dropFirst(3)) { comic in
                            ComicView(comic: comic)
                        }
                        
                    }
                }
                .navigationTitle("Marvel Comics")
                .onAppear{
                    viewModel.fetchComics()
                }
            }
            .tabItem{
                VStack {
                    Image(systemName: "house")
                        .font(.system(size: 22))
                        .foregroundColor(.red)
                    Text("Home")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                }
            }
            SearchView()
                .tabItem{
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24))
                        Text("Search")
                            .font(.system(size: 16))
                    }
                }
        }
        .accentColor(.red)
    }
}
#Preview {
    HomeView()
}

