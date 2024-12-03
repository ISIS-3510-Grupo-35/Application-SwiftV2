//
//  Optimization.swift
//  UniParkV2
//
//  Created by Tomas Angel on 2/12/24.
//

if let selectedListing {
    withAnimation(.spring) {
        ListingMapPreviewView(listing: selectedListing)
            .onTapGesture { showDetails.toggle() }
    }
}


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
