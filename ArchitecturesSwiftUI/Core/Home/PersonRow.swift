//
//  PersonRow.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 06/02/23.
//

import SwiftUI

struct PersonRow: View {
    var person: Person
    
    var body: some View {
        HStack {
            ImageView(person: person)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading) {
                Text(person.displayName)
                    .font(.headline)
                Text(person.details)
                    .multilineTextAlignment(.leading)
                    .font(.caption)
            }
            
            Spacer()
        }
    }
}

struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        PersonRow(person: Person.example)
    }
}
