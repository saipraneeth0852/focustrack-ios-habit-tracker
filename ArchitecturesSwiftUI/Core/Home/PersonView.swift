//
//  PersonView.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 06/02/23.
//

import SwiftUI

struct PersonView: View {
    var person: Person
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .center, spacing: 10) {
                    ImageView(person: person)
                        .frame(height: 300)
                        .overlay {
                            Rectangle()
                                .strokeBorder(.primary.opacity(0.1), lineWidth: 15)
                        }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(person.bio)
                        Text(person.details)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("**Experience:** ^[\(person.experience) years](inflect: true)")
                            Text("**Rate:** $\(person.rate)")
                            Text(.init("**Contact:** \(person.email)"))
                            
                        }
                        .padding(.top, 20)
                    }
                }
                .padding(20)
            }
        }
        .navigationTitle(person.displayName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PersonView(person: Person.example)
        }
    }
}
