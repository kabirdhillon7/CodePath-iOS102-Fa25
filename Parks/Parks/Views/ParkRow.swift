//
//  ParkRow.swift
//  Parks
//
//  Created by Kabir Dhillon on 10/19/25.
//

import SwiftUI

/// A View for a Park
struct ParkRow: View {
    
    // MARK: - Properties
    
    let park: Park
    
    // MARK: - Views
    
    var body: some View {
        
        // Park row
        Rectangle()
            .aspectRatio(4/3, contentMode: .fit)
            .overlay {
                // TODO: Get image url
                let image = park.images.first
                let urlString = image?.url
                let url = urlString.flatMap { string in
                    URL(string: string)
                }
                
                // TODO: Add AsyncImage
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color(.systemGray4)
                }
            }
            .overlay(alignment: .bottomLeading) {
                Text(park.name)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
            }
            .cornerRadius(16)
            .padding(.horizontal)
    }
}

#Preview {
    ParkRow(park: Park.mocked)
}
