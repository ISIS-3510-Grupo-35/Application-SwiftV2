//
//  DestinationSearchView.swift
//  UniParkV2
//
//  Created by Tomas Angel on 23/10/24.
//

import SwiftUI

enum DestinationSearchOptions {
    case location
    case dates
    case hours
}

struct DestinationSearchView: View {
    @Binding var show: Bool
    @ObservedObject var viewModel: ExploreViewModel
    @State private var selectedOption: DestinationSearchOptions = .location
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var numHours = 0
    
    var body: some View {
        VStack{
            HStack {
                Button {
                    withAnimation(.snappy){
                        viewModel.updateListingsForLocation()
                        show.toggle()
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                    Spacer()
                }
                Spacer()
                
                if !viewModel.searchLocation.isEmpty {
                    Button ("Clear") {
                        viewModel.searchLocation = ""
                        viewModel.updateListingsForLocation()
                    }
                    .foregroundStyle(.black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
            }
            .padding()
            
            VStack (alignment: .leading) {
                if selectedOption == .location {
                    Text("Where to?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.small)
                        
                        TextField("Search your university", text: $viewModel.searchLocation)
                            .font(.subheadline)
                            .onSubmit {
                                print("Update listings")
                                viewModel.updateListingsForLocation()
                                show.toggle()
                            }
                    }
                    .frame(height: 44)
                    .padding(.horizontal)
                    .overlay{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(Color(.systemGray4))
                    }
                } else {
                    CollapsedPickerView(title: "Where", description: "Add destination")
                }
            }
            .modifier(CollapsableDestinationViewModifier())
            .frame(height:selectedOption == .location ? 120 : 64)
            .onTapGesture {
                withAnimation(.snappy) { selectedOption = .location }
            }
            
            //date selection view
            VStack (alignment: .leading){
                if selectedOption == .dates {
                    Text("When's your trip?")
                        .font(.title2)
                        .fontWeight(.semibold)
                    VStack {
                        DatePicker("From", selection: $startDate, displayedComponents: .date)
                        Divider()
                        DatePicker("To", selection: $endDate, displayedComponents: .date)
                    }
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                } else {
                    CollapsedPickerView(title: "When", description: "Add date")
                }
            }
            .modifier(CollapsableDestinationViewModifier())
            .frame(height: selectedOption == .dates ? 180 : 64)
            .onTapGesture {
                withAnimation(.snappy) { selectedOption = .dates }
            }
            
            // time of arrival view
            VStack (alignment: .leading) {
                if selectedOption == .hours {
                    Text ("How many hours?")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Stepper {
                        Text("\(numHours) Hours")
                    } onIncrement: {
                        numHours += 1
                    } onDecrement: {
                        guard numHours > 0 else {return}
                        numHours -= 1
                    }
                    
                } else {
                    CollapsedPickerView(title: "What time", description: "Add time of arrival")
                }
            }
            .modifier(CollapsableDestinationViewModifier())
            .frame(height: selectedOption == .hours ? 120 : 64)
            .onTapGesture {
                withAnimation(.snappy) { selectedOption = .hours }
            }
            Spacer()
        }
    }
}

#Preview {
    DestinationSearchView(show: .constant(false),
                          viewModel: ExploreViewModel(service: ExploreService()))
}

struct CollapsableDestinationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding()
            .shadow(radius: 10)
    }
}

struct CollapsedPickerView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Text(description)
            }
            .fontWeight(.semibold)
            .font(.subheadline)
        }
    }
}
