//
//  MainPageContentView.swift
//  TournamentDay
//
//  Created by cyrus.fenderson@avalara.com on 4/27/23.
//

import SwiftUI

struct MainPageContentView: View {
    @Binding var selectedTab: Tabs
    @Binding var liveGameId: String
    var body: some View {
        if selectedTab == .games {
            RecentGamesView(selectedTab: $selectedTab, liveGameId: $liveGameId)
        }
        if selectedTab == .teamStats {
            TeamStatsView()
        }
        if selectedTab == .settings {
            RosterView()
        }
        if selectedTab == .liveGame {
            LiveGameView(selectedTab: $selectedTab, liveGameBinding: $liveGameId, liveGameId: liveGameId)
        }
    }
}

struct MainPageContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageContentView(selectedTab: .constant(.games), liveGameId: .constant(""))
    }
}
