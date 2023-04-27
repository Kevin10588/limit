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
    
    var body: some View {
        NavigationView {
            List{
                ForEach(0..<15, id: \.self) { number in
                    NavigationLink(destination: ReminderDetailView(title: "Title \(number)", description: "Description \(number)")){
                        VStack(alignment: .leading){
                            Text("Titles \(number)")
                                .font(.title)
                            Text("Description \(number)")
                        }
                    }
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
            .sheet(isPresented: $showSheet, content: {AddReminderView()})
        }
    }
}
        
    
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
            InfoView()
                .environmentObject(SessionServiceImpl())
    }
}


