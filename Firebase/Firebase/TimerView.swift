//
//  TimerView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/14/23.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject var timerManager = TimerManager()
    
    @State var selectedPickerIndex = 0
    
    let availableMinutes = Array(1...59)
    
    var body: some View {
        NavigationView {
            VStack {
                Text(secondsToMinutes(seconds:timerManager.secondsLeft))
                    .font(.system(size: 80))
                    .padding(.top, 80)
                Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if self.timerManager.timerMode == .initial {
                            self.timerManager.setTimerLength(minutes: self.availableMinutes[self.selectedPickerIndex]*60)
                        }
                        self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                    }
                if timerManager.timerMode == .paused {
                    Image(systemName: "arrowshape.turn.up.backward.2")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.top, 40)
                        .onTapGesture {
                            self.timerManager.reset()
                        }
                }
                if timerManager.timerMode == .initial {
                    Picker(selection: $selectedPickerIndex,label: Text("")) {
                        ForEach(0 ..< availableMinutes.count) {
                            Text("\(self.availableMinutes[$0]) min")
                        }
                    }
                    .labelsHidden()
                }
                Spacer()
            }
            .navigationTitle("Set Limit")
        }
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
