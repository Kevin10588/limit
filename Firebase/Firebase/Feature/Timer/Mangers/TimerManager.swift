//
//  TimerManager.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/21/23.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    
    @Published var timerMode: TimerMode = .initial
    
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
    
    @State private var selectedDate = Date()
    
    let notify = NotificationHandler()
    
    var timer = Timer()
    
    func setTimerLength(minutes: Int) {
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        secondsLeft = minutes
    }
    
    func start() {
        timerMode = .running
        // Allows timer to continue counting in background
        var backgroundTask: UIBackgroundTaskIdentifier = .invalid
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "BackgroundTask") {
            UIApplication.shared.endBackgroundTask(backgroundTask)
                    backgroundTask = .invalid
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.secondsLeft == 0 {
                self.reset()
                self.notify.sendNotification(
                    date: Date(),
                    type: "time",
                    timeInterval: 0.1,
                    title: "Limit",
                    body: "Time is up!")
            }
            self.secondsLeft -= 1
        })
        
        
    }
    
    func reset() {
        self.timerMode = .initial
        self.secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    func pause() {
        self.timerMode = .initial
        timer.invalidate()
    }
}

