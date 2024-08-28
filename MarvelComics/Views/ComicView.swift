//
//  ComicView.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 27/08/2024.
//

import Foundation
import SwiftUI

struct ComicView: View{
    let comic: Comic
    var body: some View {
        GeometryReader{ geometry in
            NavigationLink(destination: DetailsView(comic: comic)){
                HStack {
                    if let imageUrl = comic.thumbnail.fullImageURL {
                        AsyncImage(url: imageUrl) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFill()
                        .frame(
                            width: geometry.size.width / 2.2,
                            height:geometry.size.height)
                        .clipShape(Rectangle())
                    }
                    
                    VStack(alignment: .leading) {
                        Text(comic.title)
                            .font(.headline)
                            .padding([.bottom, .leading, .trailing], 2)
                            .lineLimit(3)
                            .foregroundStyle(.black)
                        
                        if let creator = comic.creators.items.first {
                            Text("Written by \(creator.name)")
                                .font(.subheadline)
                                .padding([.bottom, .leading, .trailing], 2)
                                .foregroundColor(.gray)
                        }
                        
                        if let description = comic.textObjects?.first?.text {
                            Text(description)
                                .font(.body)
                                .lineLimit(5)
                                .foregroundStyle(.black)
                                .padding([.leading, .trailing], 5)
                        } else {
                            Text("No description available")
                                .font(.body)
                        }
                    }
                }
                .shadow(radius: 5)
            }
        }
        .frame(width: UIScreen.main.bounds.width / 1.1, height: 250)
        .background(Color.white)
        
    }
}


