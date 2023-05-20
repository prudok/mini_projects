//
//  ProgressRing.swift
//  FastingTimer
//
//  Created by home on 19.05.2023.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var fastingManager: FastingManager
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            // MARK: Placeholder ring
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            // MARK: Colored ring
            Circle()
                .trim(from: 0.0, to: min(fastingManager.elapsedProgress, 1.0))
                .stroke(Gradient(colors: [ Color(#colorLiteral(red: 0.6012230515, green: 0.4945661426, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.1880010366, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.7102498412, green: 0, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.7826519608, green: 0.6337951422, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5851848125, blue: 0.8890176415, alpha: 1))]), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.0), value: fastingManager.elapsedProgress)
            
            VStack(spacing: 30) {
                if fastingManager.fastingState == .notStarted {
                    // MARK: Upcoming fast
                    VStack(spacing: 5) {
                        Text("Upcoming fast")
                            .opacity(0.7)
                        
                        Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.top)
                } else {
                    // MARK: Elapsed time
                    VStack(spacing: 5) {
                        Text("Upcoming fast (\(fastingManager.elapsedProgress.formatted(.percent)))")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.top)
                    
                    // MARK: Remaining time
                    VStack(spacing: 5) {
                        if !fastingManager.elapsed {
                            Text("Remaining time (\((1 - fastingManager.elapsedProgress).formatted(.percent)))")
                                .opacity(0.7)
                        } else {
                            Text("Extra time:")
                                .opacity(0.7)
                        }
                        Text(fastingManager.endTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                
            }
        }
        .frame(width: 250.0, height: 250.0)
        .padding()
        .onReceive(timer) { _ in
            fastingManager.track()
        }
        
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
            .environmentObject(FastingManager())
    }
}
