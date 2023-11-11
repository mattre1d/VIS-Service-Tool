//
//  YawView.swift
//  L9 Service Tool
//
//  Created by Matt Reid on 8/9/2022.
//

import SwiftUI

struct YawView: View {
    
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
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    yawText
                    yawBubble
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: 75)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Text("Tap screen to Calibrate/Zero")
                    .font(.footnote)
                    .foregroundColor(.primary.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
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
            motionDetector.yawStart = motionDetector.yaw
            motionDetector.yawAngle = 0
            firstUse = false
        }
        
    }
    
    var yawText: some View {
        VStack {
            Text("Yaw Angle")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(x: -25)
            Text(!firstUse ? "\(motionDetector.yawAngle, specifier: "%.1f") °" : "-.- °")
                .font(.system(size: 100))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top)
    }
    
    var yawBubble: some View {
        Circle()
            .trim(from: 0.5, to: 1.0)
            .foregroundStyle(Color.secondary.opacity(0.25))
            .frame(width: levelSize, height: levelSize)
        
            .overlay(
                ZStack {
                    Path { path in
                        path.move(to: CGPoint(x: levelSize / 2, y: levelSize / 2))
                        path.addArc(center: .init(x: levelSize / 2, y: levelSize / 2), radius: 100, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: !firstUse && motionDetector.yawAngle > 0 ? motionDetector.yawAngle - 180 : 180), clockwise: false)
                    }
                    
                    .fill(Color("HxGNGreen"))
                    Circle()
                        .trim(from: 0.5, to: 1.0)
                        .stroke(lineWidth: 0.5)
                        .frame(width: 20, height: 20)
                    
                    Rectangle()
                        .frame(width: 0.5, height: 20)
                        .position(x: levelSize / 2, y: levelSize / 2 - 10)
                    
                    horizontalLine
                    
                    verticalLine
                        .position(x: levelSize / 2, y: 0)
                    
                    horizontalLine
                        .position(x: 0, y: levelSize / 2)
                    
                    horizontalLine
                        .position(x: levelSize, y: levelSize / 2)
                    
                    Text("0°")
                        .position(x: -35, y: levelSize / 2 - 5)
                        .font(.subheadline)
                    
                    Text("90°")
                        .position(x: levelSize / 2 + 3, y: -35)
                        .font(.subheadline)
                    
                    Text("180°")
                        .position(x: levelSize + 40, y: levelSize / 2 - 5)
                        .font(.subheadline)
                }
            )
    }
}

struct YawView_Previews: PreviewProvider {
    @StateObject static var motionDetector = MotionDetector(updateInterval: 0.01).started()
    
    static var previews: some View {
        
        YawView()
            .preferredColorScheme(.light)
            .environmentObject(motionDetector)
            .previewInterfaceOrientation(.landscapeRight)
    }
    
}






