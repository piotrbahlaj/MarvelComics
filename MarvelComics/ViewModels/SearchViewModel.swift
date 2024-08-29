//
//  SearchViewModel.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 28/08/2024.
//

import Foundation
import SwiftUI

@MainActor
class SearchViewModel: ObservableObject{
    @Published var searchedComics: [Comic] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var query: String = "" {
        didSet{
            debouncer.debounce{
                Task{
                    await self.searchComics()
                }
            }
        }
    }
    
    private let marvelService = MarvelService()
    private let debouncer = Debouncer(delay: 0.5)
    
    func searchComics() async {
        guard !query.isEmpty else {
            DispatchQueue.main.async {
                self.searchedComics = []
            }
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        print("Searching for query: \(query)")
        
        do {
            let results = try await marvelService.searchComicsImpl(query: query)
            DispatchQueue.main.async {
                self.searchedComics = results
                self.isLoading = false
                print("Found \(results.count) comics")
            }
        } catch {
            DispatchQueue.main.async{
                self.errorMessage = "Failed to fetch comics. Please try again"
                self.isLoading = false
                print("Error fetching comics: \(error.localizedDescription)")
            }
        }
    }
}
