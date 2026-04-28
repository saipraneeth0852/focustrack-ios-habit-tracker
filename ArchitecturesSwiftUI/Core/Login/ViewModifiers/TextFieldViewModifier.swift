//
//  TextFieldViewModifier.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 05/02/23.
//

import SwiftUI

extension View {
    
    func withDefaultTextFieldFormatting() -> some View {
        modifier(TextFieldViewModifier())
    }
}

struct TextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(9)
            .background(.white.opacity(0.8))
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.2), radius: 5, x: 5, y: 5)
    }
}
