//
//  LoginViewModel.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 05/02/23.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var credentials = Credentials()
    
    @Published var error: String?
    @Published var presentError: Bool = false
    @Published var showProgressView = false
    
    init() { }
    
    public func signIn(completionHandler: @escaping(Bool) -> Void) {
        guard
            !credentials.email.isEmpty,
            !credentials.password.isEmpty
        else { return }
        
        showProgressView = true
        
        CredentialService.shared.signIn(user: credentials) { [weak self] result in
            switch result {
            case .success(_):
                completionHandler(true)
                self?.credentials = Credentials()
                
            case .failure(let error):
                self?.error = error.localizedDescription
                self?.presentError = true
                self?.credentials.password = ""
                completionHandler(false)
            }
            
            self?.showProgressView = false
        }
    }
    
    public func createUser(completionHandler: @escaping(Bool) -> Void) {
        guard
            !credentials.email.isEmpty,
            !credentials.password.isEmpty,
            credentials.password == credentials.confirmPassword
        else { return }
        
        showProgressView = true
        
        CredentialService.shared.createUser(user: credentials) { [weak self] result in
            switch result {
            case .success(_):
                completionHandler(true)
                self?.credentials = Credentials()
                
            case .failure(let error):
                self?.error = error.localizedDescription
                self?.presentError = true
                self?.credentials.password = ""
                self?.credentials.confirmPassword = ""
                completionHandler(false)
            }
            
            self?.showProgressView = false
        }
    }
}
