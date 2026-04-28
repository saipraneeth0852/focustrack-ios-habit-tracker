//
//  ImageViewModel.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 06/02/23.
//

import SwiftUI
import Combine

class ImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let person: Person
    private let dataService: ImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(person: Person) {
        self.person = person
        self.dataService = ImageService(person: person)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] returnedImage in
                self?.image = returnedImage
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
}
