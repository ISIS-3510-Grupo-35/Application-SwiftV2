//
//  MapListingPreviewView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 27/10/24.
//

import SwiftUI

struct ListingMapPreviewView: View {
    let listing: Listing
    
    var body: some View {
        VStack {
            TabView {
                ForEach (listing.imageURLs, id: \.self) { imageUrl in
                    Image(imageUrl)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Rectangle())
                }
            }
            .frame(height: 200)
            .tabViewStyle(.page)
            
            HStack (alignment: .top) {
                VStack (alignment: .leading) {
                    Text("\(listing.title), \(listing.university)")
                        .fontWeight(.semibold)
                    Text("\(listing.numberOfSpots) spots available")
                    
                    HStack (spacing: 4){
                        Text("\(listing.pricePlain) plain fee")
                    }
                }
                Spacer()
                Text("\(listing.rating)")
            }
            .font(.footnote)
            .padding(8)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
    }
}

#Preview {
    ListingMapPreviewView(listing: DeveloperPreview.shared.listings[0])
}
