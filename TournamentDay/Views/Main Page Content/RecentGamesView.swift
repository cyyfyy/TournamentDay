//
//  RecentGamesView.swift
//  TournamentDay
//
//  Created by cyrus.fenderson@avalara.com on 4/27/23.
//

import SwiftUI

struct GameRow: View {
    var game: Game
    var body: some View {
        HStack {
            Text(game.teamOneName ?? "")
            Text("vs")
            Text(game.teamTwoName ?? "")
            //        Text(String(game.date))
        }
    }
}

struct RecentGamesView: View {
    @FetchRequest var recentGames: FetchedResults<Game>
    init() {
        let request = Game.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Game.date, ascending: false)]
        request.fetchLimit = 3;
        _recentGames = FetchRequest(fetchRequest: request)
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
                                GameRow(game: game)
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
        RecentGamesView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
