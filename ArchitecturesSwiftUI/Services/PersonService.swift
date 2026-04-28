//
//  PersonService.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 06/02/23.
//

import Foundation

class PersonService {
    @Published var allPersons: [Person] = []
    
    init() {
        
    }
    
    func fetchPersons() async throws {
        guard let url = URL(string: "https://hws.dev/designers.json") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Person].self, from: data)
            self.allPersons = decoded
        } catch {
            throw error
        }
    }
}
