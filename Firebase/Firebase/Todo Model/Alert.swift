//
//  Alert.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 5/8/23.
//
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidform = AlertItem(title: Text("Invalid Form"), message: Text("Please ensure all fields in the form have been filled"), dismissButton: .default(Text("OK")))
}

