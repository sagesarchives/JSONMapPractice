//
//  ContentView.swift
//  JSONMapPractice
//
//  Created by Nyla Wilson on 9/24/26.
//

import SwiftUI

enum AppViewMode: String, Codable {
    case unselected
    case admin
    case user
}

struct ContentView: View {
    @AppStorage("selected_app_mode") private var currentMode: AppViewMode = .unselected
    
    var body: some View {
        Group {
            switch currentMode {
            case .unselected:
                SelectionScreenView(currentMode: $currentMode)
                    .transition(.opacity)
            case .admin:
                AdminView()
                    .transition(.move(edge: .trailing))
            case .user:
                UserView()
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut(duration: 0.4), value: currentMode)
    }
}

#Preview("Fresh Launch") {
    UserDefaults.standard.removeObject(forKey: "selected_app_mode")
    
    return ContentView()
}
