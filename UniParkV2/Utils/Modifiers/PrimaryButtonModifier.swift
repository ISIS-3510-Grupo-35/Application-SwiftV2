//
//  PrimaryButtonModifier.swift
//  UniParkV2
//
//  Created by Tomas Angel on 28/10/24.
//

import Foundation
import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .frame(width: 352, height: 44)
            .background(Color(.systemYellow))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
