//
//  HomeViewModel.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 06/02/23.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
//    @MainActor
    @Published var allPersons: [Person] = []
    
    var personService = PersonService()
    
    init() {
//        addSubscribers()
    }
    
//    private func addSubscribers() {
//
//        Task {
//            for await value in personService.$allPersons.values {
//                await MainActor.run(body: {
//                    self.allPersons = value
//                })
//            }
//        }
//    }
    
    func getPersons() async throws {
        do {
            try await personService.fetchPersons()
            self.allPersons = personService.allPersons
        } catch {
            throw error
        }
    }
}
