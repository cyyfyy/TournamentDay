//
//  LiveGameView.swift
//  TournamentDay
//
//  Created by cyrus.fenderson@avalara.com on 4/27/23.
//

import SwiftUI

struct LiveGameView: View {
    @FetchRequest(sortDescriptors: []) var players: FetchedResults<Player>
    var body: some View {
        List(players) { player in
            Text(player.name!)
        }
    }
}

struct LiveGameView_Previews: PreviewProvider {
    static var previews: some View {
        LiveGameView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
