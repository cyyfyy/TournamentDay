//
//  CreateGameView.swift
//  TournamentDay
//
//  Created by cyrus on 4/25/23.
//

import SwiftUI

struct CreateGameView: View {
    @Environment(\.managedObjectContext) var context
    @Binding var path: [String]
    @State private var location: String = ""
    @State private var homeTeam: String = ""
    @State private var awayTeam: String = ""
    @State private var date: Date = Date.now
    var body: some View { 
        ZStack {
            Color(.black).ignoresSafeArea()
            Form {
                Section(header: Text("Game Details")) {
                    LabeledContent {
                        TextField("Required", text: $location).textFieldStyle(.roundedBorder).padding()
                    } label: {
                        Text("Game Location")
                    }
                    LabeledContent {
                    TextField("Required", text: $homeTeam).textFieldStyle(.roundedBorder).padding()
                    } label: {
                        Text("Home Team Name")
                    }
                    LabeledContent {
                    TextField("Required", text: $awayTeam).textFieldStyle(.roundedBorder).padding()
                    } label: {
                        Text("Away Team Name")
                    }
                    DatePicker("Game Day", selection: $date, displayedComponents: [.date])
                }
               
                Section {
                    HStack {
                        Spacer()
                        Button {
                            self.addGame()
                        } label: {
                            Text("Save")
                        }.buttonStyle(.borderedProminent).disabled(location.isEmpty || homeTeam.isEmpty || awayTeam.isEmpty)
                        Spacer()
                    }
                }
            }.preferredColorScheme(.dark)
        }
    }
    
    func addGame() {
        let newGame = Game(context: context)
        newGame.id = UUID()
        newGame.location = location
        newGame.teamOneName = homeTeam
        newGame.teamTwoName = awayTeam
        newGame.date = date
        do {
            try context.save()
            path = []
        } catch {
            print(error)
        }
    }
}

struct CreateGameView_Previews: PreviewProvider {
    @State static var staticPath: [String] = []
    static var previews: some View {
        CreateGameView(path: $staticPath)
    }
}

