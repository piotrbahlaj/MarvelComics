//
//  SplashScreenViewModel.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 29/08/2024.
//

import Foundation
import SwiftUI

class LaunchScreenViewModel: ObservableObject {
    @Published var isSplashActive: Bool = true
    
    func startLaunchScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation{
                self.isSplashActive = false
            }
        }
    }
}
