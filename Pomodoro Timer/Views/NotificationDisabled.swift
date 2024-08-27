//
//  NotificationDisabled.swift
//  Pomodoro Timer
//
//  Created by Aakash Ambodkar
//

import SwiftUI

struct NotificationDisabled: View {
    var body: some View {
        VStack {
            Text("Notifications are disabled")
                .font(.headline)
            Text("To be notified, enable notifications")
                .font(.subheadline)
            
            Button("Open Settings") {
                openSettings()
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .background(Color("Light"))
        .cornerRadius(15.0)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .padding(.vertical)
    }
    
    private func openSettings() {
        DispatchQueue.main.async {
            // Open settings
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            
        }
    }
}

#Preview {
    VStack {
        NotificationDisabled()
    }
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    .background(Color("Dark"))
}
