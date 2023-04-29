//
//  MainPageContentView.swift
//  TournamentDay
//
//  Created by cyrus.fenderson@avalara.com on 4/27/23.
//

import SwiftUI

struct MainPageContentView: View {
    @Binding var selectedTab: Tabs
    var body: some View {
        if selectedTab == .games {
            RecentGamesView()
        }
        if selectedTab == .teamStats {
            TeamStatsView()
        }
        if selectedTab == .settings {
            RosterView()
        }
    }
}

struct MainPageContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageContentView(selectedTab: .constant(.games))
    }
}
