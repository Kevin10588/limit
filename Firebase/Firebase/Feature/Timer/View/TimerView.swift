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

    @State var showScreenShield = false
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
                        // new screen view covers the entire screen when starting the timer
                        showScreenShield.toggle()
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
                    .fullScreenCover(isPresented: $showScreenShield, content: {
                                ScreenShieldView(timerManager: timerManager, score: score, dismissAction: {
                                    showScreenShield = false
                                })
                            })
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

//Screen view that appears when timer started
struct ScreenShieldView: View {
    @State var showScreenShield = false
    let timerManager : TimerManager
    let score : Score
    let dismissAction: () -> Void
    var body: some View {
        
        // Shield that covers the entire screen
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .allowsHitTesting(true)
            
            VStack(spacing: 20) {
                Text("Productive Mode ")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80, alignment: .center)
                    .foregroundColor(Color.accentColor)
                    .padding(.top)
                Text(secondsToMinutes(seconds:timerManager.secondsLeft))
                    .font(.system(size: 80))
                    .padding(.top, 80)
                
                if timerManager.showButton {
                    //Button appears to Disable Shield after timer runs out
                    //add to score when press the button
                    Button("Good Job!", action: {
                        dismissAction()
                        score.addScore()
                    })
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()

                //Disable Shield in case of an emergency but also for testing
                //Everytime you disable then the score decrements
                Button("Disable", action: {
                    dismissAction()
                    score.penalize()
                })
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
              
                
                }
        }
    }
}
