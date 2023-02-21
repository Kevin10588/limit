//
//  TimerModel.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/21/23.
//

import Foundation

enum TimerMode {
    case running
    case paused
    case initial
}

func secondsToMinutes(seconds: Int) -> String {
    let minutes = "\((seconds % 3600) / 60)"
    let seconds = "\((seconds % 3600) % 60)"
    let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
    let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
    
    return "\(minuteStamp) : \(secondStamp)"
}
