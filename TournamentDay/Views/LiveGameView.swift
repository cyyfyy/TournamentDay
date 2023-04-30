//
//  LiveGameView.swift
//  TournamentDay
//
//  Created by cyrus.fenderson@avalara.com on 4/27/23.
//

import SwiftUI

struct LiveGameView: View {
    @Environment(\.managedObjectContext) var context
    @Binding var liveGameId: String
    @Binding var selectedTab: Tabs
    @State private var currentPointStats: [Stat] = []
    @State private var homeTeamScore: Int32 = 0
    @State private var awayTeamScore: Int32 = 0
    @FetchRequest var liveGame: FetchedResults<Game>
    init(selectedTab: Binding<Tabs>, liveGameBinding: Binding<String>, liveGameId: String) {
        let request = Game.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Game.date, ascending: false)]
        request.fetchLimit = 1;
        request.predicate = NSPredicate(format: "id == %@", liveGameId)
        _liveGame = FetchRequest(fetchRequest: request)
        _selectedTab = selectedTab
        _liveGameId = liveGameBinding
    }
    
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Text("t1")
                    Text(String(homeTeamScore))
                    Spacer()
                    Text("t2")
                    Text(String(awayTeamScore))
                    Spacer()
                }.foregroundColor(.white).onAppear() {
                    homeTeamScore = liveGame.first?.teamOneScore ?? 0
                    awayTeamScore = liveGame.first?.teamTwoScore ?? 0
                }
                Spacer()
                HStack {
                    Button {
                        endPoint(home: true)
                    } label: {
                        ZStack {
                            Rectangle().fill(Color.green).cornerRadius(10)
                            Text("Home team scored").foregroundColor(.white).fontWeight(.bold).font(.system(size: 46))
                        }
                    }
                    Button {
                        endPoint(home: false)
                    } label: {
                        ZStack {
                            Rectangle().fill(Color.gray).cornerRadius(10)
                            Text("Away team scored").foregroundColor(.white).fontWeight(.bold).font(.system(size: 46))
                        }
                    }
                }
                HStack {
                    Button {
                        addStat(turn: false)
                    } label: {
                        ZStack {
                            Rectangle().fill(Color.blue).cornerRadius(10)
                            Text("Home team\nD").foregroundColor(.white).fontWeight(.bold).font(.system(size: 46))
                        }
                    }
                    Button {
                        addStat(turn: true)
                    } label: {
                        ZStack {
                            Rectangle().fill(Color.purple).cornerRadius(10)
                            Text("Home team turnover").foregroundColor(.white).fontWeight(.bold).font(.system(size: 46))
                        }
                    }
                }
                Spacer()
                Button{
                    endGame()
                }label: {
                    Text("End Game")
                }.buttonStyle(.borderedProminent).tint(.red)
            }
        }
    }
    
    func addStat(turn: Bool) {
        let newStat = Stat(context: context)
        newStat.id = UUID()
        newStat.playerId = UUID()
        newStat.playerTwoId = UUID()
        newStat.type = turn ? "turn" : "d"
        currentPointStats.append(newStat)
    }
    
    func endPoint(home: Bool) {
        let newPoint = Point(context: context)
        newPoint.id = UUID()
        newPoint.number = Int32(homeTeamScore + awayTeamScore)
        let g = liveGame.first;
        if home {
            homeTeamScore += 1
            g?.teamOneScore = homeTeamScore

        } else {
            awayTeamScore += 1
            g?.teamTwoScore = awayTeamScore
        }
        do {
            if context.hasChanges {
                print("Changes detected on end point")
                try context.save()
            }
        } catch {
            print(error)
        }
        currentPointStats = []
    }
    
    func endGame() {
        do {
            if context.hasChanges {
                print("Changes detected on end game")
                try context.save()
            }
        } catch {
            print(error)
        }
        selectedTab = .games
    }
    
}

struct LiveGameView_Previews: PreviewProvider {
    @State static var liveGameBinding: String = "123"
    static var previews: some View {
        LiveGameView(selectedTab: .constant(.liveGame), liveGameBinding: $liveGameBinding, liveGameId: liveGameBinding).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
