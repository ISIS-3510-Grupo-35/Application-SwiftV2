//
//  MapParkingLotPreviewView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 27/10/24.
//

import SwiftUI

struct ParkingLotMapPreviewView: View {
    let parkingLot: ParkingLot
    
    var body: some View {
        VStack {
            TabView {
                AsyncImage(url: URL(string: parkingLot.image))
                { image in image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(12)
                        .padding(.bottom)
                } placeholder: {
                    ProgressView()
                        .frame(height: 200)
                }
                .frame(height: 200)
                .tabViewStyle(.page)
            }
            HStack (alignment: .top) {
                VStack (alignment: .leading) {
                    Text("\(parkingLot.name)")
                        .fontWeight(.semibold)
                    Text("\(parkingLot.capacity) spots available")
                    
                    HStack (spacing: 4){
                        Text("\(parkingLot.fullRate) plain fee")
                    }
                }
                Spacer()
                Text("\(parkingLot.review)")
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
    //ParkingLotMapPreviewView()
}
