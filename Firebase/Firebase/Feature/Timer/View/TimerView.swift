//
//  TimerView.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/14/23.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject var timerManager = TimerManager()
    let score : Score

    
    @State var selectedPickerIndex = 0
    
    let availableMinutes = Array(1...59)
        
    var body: some View {
        NavigationView {
            VStack {
                Text(secondsToMinutes(seconds:timerManager.secondsLeft))
                    .font(.system(size: 80))
                    .padding(.top, 80)
                Image(systemName: timerManager.timerMode == .running ? "alarm.waves.left.and.right.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if self.timerManager.timerMode == .initial {
                            self.timerManager.setTimerLength(minutes: self.availableMinutes[self.selectedPickerIndex]*60)
                        }
                        self.timerManager.timerMode == .running ? print("running") : self.timerManager.start()
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
                    .pickerStyle(.wheel)
                    .labelsHidden()
                }
                Spacer()
            }
            .navigationTitle("Set Timer")
        }
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(score:Score())
    }
}
