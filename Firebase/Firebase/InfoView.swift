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
}
        
    
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
            InfoView()
                .environmentObject(SessionServiceImpl())
    }
}


