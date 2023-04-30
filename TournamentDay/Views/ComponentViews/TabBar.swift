//
//  TabBar.swift
//  TournamentDay
//
//  Created by cyrus on 4/25/23.
//

import SwiftUI

enum Tabs: Int {
    case teamStats = 0
    case games = 1
    case settings = 2
    case liveGame = 3
}

struct TabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        ZStack {
            Color(.black)
            HStack {
                Button {
                    selectedTab = .teamStats
                } label: {
                    TabBarButton(
                        buttonText: "Team stats",
                        imageName: "folder",
                        isActive: selectedTab == .teamStats)
                }.tint(.white)
                Button {
                    selectedTab = .games
                } label: {
                    TabBarButton(
                        buttonText: "Games",
                        imageName: "livephoto.play",
                        isActive: selectedTab == .games)
                }.tint(.white)
                Button {
                    selectedTab = .settings
                } label: {
                    TabBarButton(
                        buttonText: "Team Setup",
                        imageName: "gearshape",
                        isActive: selectedTab == .settings)
                }.tint(.white)
            }
        }.frame(height: 82)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedTab: .constant(.teamStats))
    }
}
