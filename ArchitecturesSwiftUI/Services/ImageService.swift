//
//  ImageService.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 06/02/23.
//

import SwiftUI
import Combine

class ImageService {
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let person: Person
    private let folderName = "person_images"
    private let imageName: String
    
    private let fileManager = LocalFileManager.shared
    
    init(person: Person) {
        self.person = person
        self.imageName = String(person.id)
        getImage()
    }
    
    private func getImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        
        imageSubscription = URLSession.shared.dataTaskPublisher(for: person.photo)
            .tryMap({ data, response in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return UIImage(data: data)
            })
            .retry(2)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] returnedImage in
                guard
                    let downloadedImage = returnedImage
                else { return }
                
                self?.image = downloadedImage
                self?.imageSubscription?.cancel()
            })
        
    }
}
