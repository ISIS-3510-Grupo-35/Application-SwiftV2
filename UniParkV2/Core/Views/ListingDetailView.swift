//
//  ListingDetailView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 22/10/24.
//

import SwiftUI
import MapKit

struct ListingDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    let listing: Listing
    @State private var cameraPosition: MapCameraPosition
    
    init(listing: Listing) {
        self.listing = listing
        let region = MKCoordinateRegion(center: listing.university == "Universidad de los Andes" ? .universidadDeLosAndes: .universidadDeLosAndes, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self._cameraPosition = State(initialValue: .region(region))
    }
    
    var body: some View {
        ScrollView {
            ZStack (alignment: .topLeading){
                ListingImageCarouselView(listing: listing)
                    .frame(height: 320)
                Button{
                    dismiss()
                }label:{
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .background {
                            Circle()
                                .fill(.white)
                                .frame(width: 32, height: 32)
                        }
                        .padding(32)
                }
            }
            
            VStack (alignment: .leading, spacing: 8) {
                Text(listing.title)
                    .font(.title)
                    .fontWeight(.semibold)
                VStack (alignment: .leading) {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                        
                        Text("\(listing.rating)")
                            .foregroundStyle(.black)
                        Text(" - ")
                        Text("28 Reviews")
                            .underline()
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.black)
                    
                    Text("\(listing.university)")
                }
                .font(.caption)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
            
            Divider()
            
            // Parking lot owner view
            HStack {
                VStack (alignment: .leading, spacing: 4){
                    Text ("Parqueadero \(listing.title) por \(listing.ownerName)")
                        .font(.headline)
                        .frame(width: 250, alignment: .leading)
                    HStack (spacing: 2){
                        Text("\(listing.numberOfSpots) spots available")
                    }
                    .font(.caption)
                }
                .frame(width: 300, alignment: .leading)
                
                Spacer()
                
                Image("uniandes-logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width:64, height: 64)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            Divider()
            
            //Listing features
            VStack (alignment: .leading, spacing: 16) {
                ForEach(listing.features) { feature in
                    HStack(spacing: 12) {
                        Image(systemName: feature.imageName)
                        
                        VStack(alignment: .leading) {
                            Text(feature.title)
                                .font(.footnote)
                                .fontWeight(.semibold)
                            Text(feature.subtitles)
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                    }
                }
            }
            .padding()
            
            Divider()
            
            // Specifications
            VStack (alignment: .leading, spacing: 16) {
                Text("Parking lot specifications") //CHANGE
                    .font(.headline)
                
                ForEach(0 ..< 5) {amenity in
                    HStack{
                        Image(systemName: "wifi") //CHANGE
                            .frame(width: 32)
                        Text("Wifi")
                            .font(.footnote)
                        
                        Spacer()
                    }
                }
            }
            .padding()
            
            Divider()
            
            // Location
            VStack(alignment: .leading, spacing: 16) {
                Text("Parking lot location")
                    .font(.headline)
                Map(position: $cameraPosition)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding()
        }
        .toolbar(.hidden, for: .tabBar)
        .ignoresSafeArea()
        .padding(.bottom, 64)
        .overlay(alignment: .bottom) {
            VStack {
                Divider()
                    .padding(.bottom)
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("$\(listing.pricePlain)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("Plain fee")
                            .underline()
                            .font(.footnote)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Reserve")
                            .foregroundStyle(.black)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 140,  height: 40)
                            .background(.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal, 32)
            }
            .background(.white)
        }
    }
}

#Preview {
    ListingDetailView(listing: DeveloperPreview.shared.listings[8])
}
