//
//  RosterView.swift
//  TournamentDay
//
//  Created by cyrus.fenderson@avalara.com on 4/27/23.
//

import SwiftUI

struct PlayerRow: View {
    var player: Player
    var body: some View {
        HStack {
            Text(player.name ?? "")
        }
    }
}

struct RosterView: View {
    @Environment(\.managedObjectContext) var context
    @State private var playerName: String = ""
    @FetchRequest var players: FetchedResults<Player>
    init() {
        let request = Player.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Player.name, ascending: true)]
        _players = FetchRequest(fetchRequest: request)
    }
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    TextField("Player Name", text: $playerName).frame(width: 200).textFieldStyle(.roundedBorder).preferredColorScheme(.dark)
                    Button {
                        self.addPlayer()
                    } label: {
                        Text("Add Player")
                    }.buttonStyle(.borderedProminent)
                    Spacer()
                }
                List {
                    if players.count < 1 {
                        Section {
                            Text("No players found, try adding one!").foregroundColor(.white)
                        } header: {
                            Text("Players").fontWeight(.bold)
                        }
                    } else {
                        Section {
                            ForEach(players) { player in
                                PlayerRow(player: player)
                            }.onDelete(perform: deletePlayers)
                        } header: {
                            Text("Players").fontWeight(.bold)
                        }
                    }
                }.cornerRadius(10).preferredColorScheme(.dark)
            }
        }
    }
    
    func deletePlayers(at offsets: IndexSet) {
        for index in offsets {
            let p = players[index]
            context.delete(p)
        }
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    func addPlayer() {
        if (playerName.count > 0) {
            let newPlayer = Player(context: context)
            newPlayer.id = UUID()
            newPlayer.name = playerName
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}

struct RosterView_Previews: PreviewProvider {
    static var previews: some View {
        RosterView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
