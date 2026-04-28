//
//  RegisterView.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 05/02/23.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject var vm: LoginViewModel
    
    @State private var isSecure = true
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Create an Account")
                    .font(.title.bold())
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                    TextField("Enter your email", text: $vm.credentials.email)
                        .withDefaultTextFieldFormatting()
                        .keyboardType(.emailAddress)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                    
                    HStack {
                        if isSecure {
                            SecureField("Enter your password", text: $vm.credentials.password)
                                .frame(height: 22)
                            
                        } else {
                            TextField("Enter your password", text: $vm.credentials.password)
                        }
                        
                        Button {
                            isSecure.toggle()
                        } label: {
                            Label("showPassword", systemImage: isSecure ? "eye.slash.fill" : "eye")
                                .labelStyle(.iconOnly)
                                .padding(.trailing, 5)
                        }
                    }
                    .withDefaultTextFieldFormatting()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password Confirmation")
                    
                    HStack {
                        if isSecure {
                            SecureField("Enter the same password again", text: $vm.credentials.confirmPassword)
                                .frame(height: 22)
                            
                        } else {
                            TextField("Enter the same password again", text: $vm.credentials.confirmPassword)
                        }
                        
                        Button {
                            isSecure.toggle()
                        } label: {
                            Label("showPassword", systemImage: isSecure ? "eye.slash.fill" : "eye")
                                .labelStyle(.iconOnly)
                                .padding(.trailing, 5)
                        }
                    }
                    .withDefaultTextFieldFormatting()
                }
                .padding(.bottom, 40)
                
                Spacer()
                
                VStack(spacing: 18) {
                    if vm.showProgressView {
                        ProgressView()
                            .padding(12)
                        
                    } else {
                        
                        Button {
                            withAnimation {
                                vm.createUser { result in
                                    appState.updateAuthorization(with: result)
                                }
                            }
                        } label: {
                            Text("Login")
                                .padding(5)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .padding(20)

        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(vm: LoginViewModel())
            .environmentObject(AppState())
    }
}
