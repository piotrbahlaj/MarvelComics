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
            HStack {
                if let imageUrl = comic.thumbnail.fullImageURL {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width / 2.7,
                        height:geometry.size.height)
                    .clipShape(Rectangle())
                }
                
                VStack(alignment: .leading) {
                    Text(comic.title)
                        .font(.headline)
                        .padding([.bottom, .leading], 2)
                        .lineLimit(3)
                    
                    if let creator = comic.creators.items.first {
                        Text("Creator: \(creator.name)")
                            .font(.subheadline)
                            .padding(.bottom, 2)
                            .foregroundColor(.gray)
                    }
                    
                    if let description = comic.textObjects?.first?.text {
                        Text(description)
                            .font(.body)
                            .lineLimit(5)
                    } else {
                        Text("No description available")
                            .font(.body)
                    }
                }
                Spacer()
            }
        }
        .background(Color.white)
        .frame(width: UIScreen.main.bounds.width, height: 250)
    }
}


