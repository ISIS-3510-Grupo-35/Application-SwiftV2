//
//  PrimaryTextFieldModifier.swift
//  UniParkV2
//
//  Created by Tomas Angel on 28/10/24.
//

import Foundation
import SwiftUI

struct PrimaryTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 24)
    }
}
