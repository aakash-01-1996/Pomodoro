//
//  CircleButton.swift
//  Pomodoro Timer
//
//  Created by Aakash Ambodkar
//

import SwiftUI

struct CircleButton: View {
    
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: icon)
                .foregroundColor(Color("Dark"))
                .frame(width: 65, height: 65)
                .background(Color(.systemGray))
                .clipShape(Circle())
        }
    }
}

#Preview {
    CircleButton(icon: "play.fill") {
        print("Hello")
    }
}
