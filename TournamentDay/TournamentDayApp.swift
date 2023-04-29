//
//  TournamentDayApp.swift
//  TournamentDay
//
//  Created by cyrus on 4/25/23.
//

import SwiftUI

@main
struct TournamentDayApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
