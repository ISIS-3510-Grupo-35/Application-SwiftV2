//
//  ViewBuilder.swift
//  UniParkV2
//
//  Created by Tomas Angel on 2/12/24.
//

if let selectedListing {
    animatedPreview(for: selectedListing)
}

// Helper function
@ViewBuilder
func animatedPreview(for listing: Listing) -> some View {
    withAnimation(.spring) {
        ListingMapPreviewView(listing: listing)
            .onTapGesture { showDetails.toggle() }
    }
}


Map(position: $cameraPosition, selection: $selectedListing) {
    ForEach(listings, id: \.self) { listing in
        Marker("", coordinate: listing.coordinates)
            .tag(listing.id)
    }
}


Map(position: $cameraPosition, selection: $selectedListing) {
    ForEach(listings, id: \.id) { listing in
        MarkerView(listing: listing)
    }
}

// Custom MarkerView for better readability and reuse
struct MarkerView: View {
    let listing: Listing
    
    var body: some View {
        Marker("", coordinate: listing.coordinates)
            .tag(listing.id)
    }
}



let profileOptions = [
    ("gear", "Settings"),
    ("gear", "Accesibility"),
    ("questionmark.circle", "Visit the help center")
]

VStack(spacing: 24) {
    ForEach(profileOptions, id: \.1) { option in
        ProfileOptionRowView(imageName: option.0, title: option.1)
    }
}
