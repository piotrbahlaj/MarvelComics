//
//  HomeViewModel.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 27/08/2024.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject{
    @Published var comics: [Comic] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let marvelService = MarvelService()
    
    func fetchComics() {
        Task{
            self.isLoading = true
            do {
                let fetchedComics = try await marvelService.fetchComicsImpl()
                DispatchQueue.main.async {
                    self.comics = fetchedComics
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async{
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
