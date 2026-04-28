//
//  ImageView.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 06/02/23.
//

import SwiftUI

struct ImageView: View {
    @StateObject var vm: ImageViewModel
    
    init(person: Person) {
        _vm = StateObject(wrappedValue: ImageViewModel(person: person))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.gray.opacity(0.6))
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(person: Person.example)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
