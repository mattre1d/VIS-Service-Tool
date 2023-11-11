//
//  PitchView.swift
//  L9 Service Tool
//
//  Created by Matt Reid on 8/9/2022.
//

import SwiftUI

struct PitchView: View {
    
    @EnvironmentObject var motionDetector: MotionDetector
    @AppStorage("isLandscape") var isLandscape = false
    @State var firstUse = true
    
    let range = Double.pi + 180
    let levelSize: CGFloat = 200
    
    var verticalLine: some View {
        Rectangle()
            .frame(width: 0.5, height: 30)
    }
    
    var horizontalLine: some View {
        Rectangle()
            .frame(width: 30, height: 0.5)
    }
    
    var bubbleYPosition: CGFloat {
        let zeroBasedRoll = motionDetector.rollAngle + range / 2
        let rollAsFraction = zeroBasedRoll / range
        if (rollAsFraction * levelSize) < 0 {
            return 0
        } else if (rollAsFraction * levelSize) > 200 {
            return 200
        } else {
            return rollAsFraction * levelSize
        }
    }
    
    var bubbleXPosition: CGFloat {
        let zeroBasedPitch = range / 2
        let pitchAsFraction = zeroBasedPitch / range
        return pitchAsFraction * levelSize
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    pitchBubble
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: 35)
                    pitchText
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Text("Tap screen to Calibrate/Zero")
                    .font(.footnote)
                    .foregroundColor(.primary.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            
            Button {
                withAnimation {
                    motionDetector.showModal = true
                }
            } label: {
                HelpButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            
            if motionDetector.showModal {
                ModalView()
            }
        }
        
        .onAppear {
            motionDetector.start()
            isLandscape = true
            AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeRight
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }
        
        .onDisappear {
            firstUse = true
        }
        
        .contentShape(Rectangle())
        .onTapGesture {
            motionDetector.rollStart = motionDetector.roll
            motionDetector.rollAngle = 0
            firstUse = false
        }
        
    }
    
    var pitchText: some View {
        VStack {
            Text("Pitch Angle")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(x: -25)
            Text(!firstUse ? "\(motionDetector.rollAngle, specifier: "%.1f") °" : "-.- °")
                .font(.system(size: 100))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top)
    }
    
    var pitchBubble: some View {
        Circle()
            .foregroundStyle(Color.secondary.opacity(0.25))
            .frame(width: levelSize, height: levelSize)
        
            .overlay(
                ZStack {
                    Circle()
                        .foregroundColor(Color("HxGNLBL"))
                        .frame(width: 50, height: 50)
                        .position(x: bubbleXPosition,
                                  y: !firstUse ? bubbleYPosition : 100)
                    Circle()
                        .stroke(lineWidth: 0.5)
                        .frame(width: 20, height: 20)
                    
                    verticalLine
                    horizontalLine
                    
                    verticalLine
                        .position(x: levelSize / 2, y: 0)
                    verticalLine
                        .position(x: levelSize / 2, y: levelSize)
                    horizontalLine
                        .position(x: 0, y: levelSize / 2)
                    horizontalLine
                        .position(x: levelSize, y: levelSize / 2)
                }
            )
    }
}

struct PitchView_Previews: PreviewProvider {
    @StateObject static var motionDetector = MotionDetector(updateInterval: 0.01).started()
    static var previews: some View {
        PitchView()
            .environmentObject(motionDetector)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
