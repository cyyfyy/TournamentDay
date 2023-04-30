//
//  RootView.swift
//  TournamentDay
//
//  Created by cyrus on 4/25/23.
//

import SwiftUI

struct RootView: View {
    
    @State private var selectedTab: Tabs = .games
    @State private var liveGameId: String = ""
    @State private var path: [String] = []
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(.black).ignoresSafeArea()
                VStack {
                    Text("Tournament Day")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    if selectedTab == .games {
                        Button {
                            path.append("create")
                        } label: {
                            Text("Create Game").frame(maxWidth:.infinity)
                                .frame(height: 32)
                        }.buttonStyle(.borderedProminent)
                            .fontWeight(.semibold)
                            .navigationDestination(for: String.self) { stringValue in CreateGameView(path: $path)
                            }
                        Image("wain")
                            .resizable()
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fit)
                    }
                    MainPageContentView(selectedTab: $selectedTab, liveGameId: $liveGameId)
                    TabBar(selectedTab: $selectedTab)
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

// Stats: score (thrower, receiver), Ds, turns
