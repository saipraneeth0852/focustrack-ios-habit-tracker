//
//  HomeView.swift
//  ArchitecturesSwiftUI
//
//  Created by Frédéric Helfer on 05/02/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.2).ignoresSafeArea()
                
                VStack {
                    List {
                        ForEach(vm.allPersons) { person in
                            NavigationLink {
                                PersonView(person: person)
                            } label: {
                                PersonRow(person: person)
                                    .frame(height: 70)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("HomeView")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.easeInOut) {
                            appState.updateAuthorization(with: false)
                        }
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                            .labelStyle(.iconOnly)
                    }
                }
            }
        }
        .task {
            do {
                try await vm.getPersons()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: HomeViewModel())
            .environmentObject(AppState())
    }
}
