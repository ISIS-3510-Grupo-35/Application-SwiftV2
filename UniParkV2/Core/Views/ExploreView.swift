//
//  ExploreView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 22/10/24.
//

import Foundation
import SwiftUI

struct ExploreView: View {
    @State private var showDestinationSearchView = false
    @StateObject var viewModel = ExploreViewModel(service: ExploreService())
    @State private var showMapView = false
    
    var body: some View {
        NavigationStack {
            if showDestinationSearchView {
                DestinationSearchView(show: $showDestinationSearchView,
                                      viewModel: viewModel)
                Spacer()
            } else {
                ZStack (alignment: .bottom){
                    ScrollView {
                        SearchAndFilterBar(location: $viewModel.searchLocation)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    showDestinationSearchView.toggle()
                                }
                            }
                        
                        LazyVStack(spacing: 32) {
                            ForEach(viewModel.listings) {listing in
                                NavigationLink(value: listing) {
                                    ListingItemView(listing: listing)
                                        .frame(height: 400)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Listing.self) { listing in
                        //Text("Listing detail view...")
                        ListingDetailView(listing: listing)
                            .navigationBarBackButtonHidden()
                    }
                    
                    Button {
                        showMapView.toggle()
                    } label: {
                        HStack {
                            Text("Map")
                            
                            Image(systemName: "paperplane")
                        }
                        .foregroundColor(.black)
                        .padding(.vertical, 12)
                        .padding(.horizontal)
                        .background(Color.yellow)
                        .clipShape(Capsule())
                        .padding()
                    }
                }
                .sheet(isPresented: $showMapView, content: {
                    ListingMapView(listings: viewModel.listings)
                })
            }
        }
        .padding()
    }
}

#Preview {
    ExploreView()
}

