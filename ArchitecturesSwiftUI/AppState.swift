//
//  AppState.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 05/02/23.
//

import Foundation

class AppState: ObservableObject {
    @Published private(set) var isAuthorized = false
    
    
    public func updateAuthorization(with: Bool) {
        isAuthorized = with
    }
}
