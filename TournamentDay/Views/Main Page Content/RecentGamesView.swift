//
//  RecentGamesView.swift
//  TournamentDay
//
//  Created by cyrus.fenderson@avalara.com on 4/27/23.
//

import SwiftUI

struct GameRow: View {
    @State var game: Game
    @Binding var liveGameId: String
    @Binding var selectedTab: Tabs
    var body: some View {
            Button {
                liveGameId = game.id?.uuidString ?? ""
                selectedTab = .liveGame
            } label: {
                HStack {
                    Text(game.teamOneName ?? "")
                    Text("vs")
                    Text(game.teamTwoName ?? "")
                }
            }
    
    }
}

struct RecentGamesView: View {
    @Binding var selectedTab: Tabs
    @Binding var liveGameId: String
    @FetchRequest var recentGames: FetchedResults<Game>
    init(selectedTab: Binding<Tabs>, liveGameId: Binding<String>) {
        let request = Game.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Game.date, ascending: false)]
        request.fetchLimit = 3;
        _recentGames = FetchRequest(fetchRequest: request)
        _selectedTab = selectedTab
        _liveGameId = liveGameId
    }
    
    var body: some View {
        ZStack {
            Color(.black)
            VStack {
                List {
                    if recentGames.count < 1 {
                        Section {
                            Text("No recent games found, try adding one!")
                        } header: {
                            Text("Recent Games").fontWeight(.bold)
                        }
                    } else {
                        Section {
                            ForEach(recentGames) { game in
                                GameRow(game: game, liveGameId: $liveGameId, selectedTab: $selectedTab)
                            }
                        } header: {
                            Text("Recent Games").fontWeight(.bold)
                        }
                    }
                }.frame(height: 200).cornerRadius(10).preferredColorScheme(.dark)
            }
        }
    }
}

struct RecentGamesView_Previews: PreviewProvider {
    static var previews: some View {
        RecentGamesView(selectedTab: .constant(.games), liveGameId: .constant(""))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
