//
//  SelectionScreenView.swift
//  JSONMapPractice
//
//  Created by Nyla Wilson on 10/12/26.
//

import SwiftUI

struct SelectionScreenView: View {
    @Binding var currentMode: AppViewMode
    
    var body: some View {
        VStack (spacing: 40) {
            Text("Welcome! Please select your grade level: ")
                .font(.title2)
                .bold()
                .padding(.bottom, 20)
            Button(action: { currentMode = .user }) {
                Label("User", systemImage: "person.badge.key.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            } // uni button
            
            Button(action: { currentMode = .admin }) {
                Label("Admin", systemImage: "figure.child")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            } // k12 button
        } // vstack ending brace
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}
