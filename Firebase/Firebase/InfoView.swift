//
//  InfoView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/28/23.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var sessionService: SessionServiceImpl
    @State var showSheet = false
    @StateObject var model = ContentViewModel()
    // creating the score instance
    @ObservedObject var score = Score()
    

    var body: some View {
        NavigationView {
            List{
                ForEach(model.items, id: \.id) { item in
                    NavigationLink(destination: ReminderDetailView(title: item.title, description: item.description)){
                        VStack(alignment: .leading){
                            Text(item.title)
                                .font(.title)
                            Text(item.description)
                        }
                    }
                }
                .onDelete { indexSet in
                    model.items.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("TODO")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "plus.app")
                    }
                }

            }
            .listStyle(.plain)
            .sheet(isPresented: $showSheet, onDismiss: model.loaditems, content:{
                AddReminderView()
                
            })
            .onAppear(){
                model.loaditems()
            }
        }
    }
    func badgeView() -> some View {
            if score.currentScore > 100 {
                return BadgeView(color: .blue, text: "Very Productive", score: score)
            } else if score.currentScore > 30 {
                return BadgeView(color: .orange, text: "Productive", score: score)
            } else if score.currentScore > 15 {
                return BadgeView(color: .green, text: "Doing Good", score: score)
            } else if score.currentScore < 0 {
                return BadgeView(color: .red, text: "Unproductive", score: score)
            } else {
                return BadgeView(color: .gray, text: "Focus", score: score)
            }
        }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
            InfoView()
                .environmentObject(SessionServiceImpl())
    }
}

//struct BadgeView: View {
//    let color: Color
//    let text: String
//    let score : Score
//
//    var body: some View {
//        Text(text)
//            .font(.caption)
//            .padding(6)
//            .foregroundColor(.white)
//            .background(color)
//            .clipShape(Capsule())
//    }
//
//}
