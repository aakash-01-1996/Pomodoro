//
//  CircleTimer.swift
//  Pomodoro Timer
//
//  Created by Aakash Ambodkar
//

import SwiftUI

struct CircleTimer: View {
    let fraction: Double = 0.5
    let primaryText: String
    let secondaryText: String
    
    var body: some View {
        ZStack{
            // background circle
            Circle()
                .fill(Color("Dark")).opacity(0.5)
            
            // timer circle
            Circle()
                .trim(from: 0, to: fraction)
                .stroke(Color("Light"), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .rotationEffect(.init(degrees: -90))
                .padding()
                .animation(.easeInOut, value: 0.5)
            
            
            // primary text
            Text(primaryText)
                .font(.system(size: 50, weight: .semibold, design: .serif))
                .foregroundColor(Color(.black))
            
            // secondary text
            Text(secondaryText)
                .font(.system(size: 25, weight: .light, design: .serif))
                .foregroundColor(Color(.black))
                .offset(y:45)
        }
        .padding()
    }
}

#Preview {
    CircleTimer(primaryText: "12.34", secondaryText: "Working")
}
