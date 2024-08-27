//
//  ContentView.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 26/08/2024.
//

import SwiftUI
struct ContentView: View {
    @State private var comics: [Comic] = []
    @State private var errorMessage: String? = nil
    private let marvelService = MarvelService()
    var body: some View {
        NavigationView{
            List(comics, id: \.id){comic in
                VStack(alignment: .leading) {
                    Text(comic.title)
                        .font(.headline)
                    if let description = comic.description{
                        Text(description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Marvel Comics")
            .task {
                do{
                    comics = try await marvelService.fetchComics()
                } catch {
                    errorMessage = error.localizedDescription
                    print("Error fetching comics: \(error)")
                }
            }
            .alert("Error", isPresented: .constant(errorMessage != nil)){
                Button("OK", role: .cancel){}
            } message: {
                Text(errorMessage ?? "Unknown error")
            }
        }
        
    }
}
    #Preview {
        ContentView()
    }

