//
//  ListingItemView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 22/10/24.
//

import SwiftUI

struct ListingItemView: View {
    let listing: Listing
    
    
    var body: some View {
        VStack(spacing: 8) {
            // images
            
            ListingImageCarouselView(listing: listing)
                .frame(height: 320)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            //listing details
            HStack (alignment: .top) {
                // details
                VStack(alignment: .leading) {
                    Text("\(listing.city), \(listing.university)")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Text("300 metros de ti")
                        .foregroundStyle(.gray)
                    
                    Text("Cupos 3")
                        .foregroundStyle(.black)
                    
                    HStack (spacing: 4) {
                        Text("\(listing.pricePlain)")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        Text("tarifa plena")
                            .foregroundStyle(.black)
                    }
                }
                
                Spacer()
                
                // rating
                HStack (spacing: 2) {
                    Image(systemName: "star.fill")
                    
                    Text("\(listing.rating)")
                        .foregroundStyle(.black)
                }
            }
            .font(.footnote)
        }
    }
}

#Preview {
    ListingItemView(listing: DeveloperPreview.shared.listings[0])
}
