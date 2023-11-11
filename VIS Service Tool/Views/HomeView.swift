//
//  HomeView.swift
//  DesignCodeIOS15
//
//  Created by Matt Reid on 4/9/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var motionDetector: MotionDetector
    @AppStorage("isLandscape") var isLandscape = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [
                .init(color: Color("LightBlue"), location: 0.00),
                .init(color: Color("DarkBlue"), location: 0.60),
            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            VStack {
                Image("Hexagon_Logo_CMYK_ColorBug_WhiteText-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(50)
                Spacer()
                VStack {
                    Text("VIS Service Tool")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .offset(x:0, y: -50)
                Spacer()
                Image("HomeViewBackground")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.2)
            }
            
        }
        
        .onAppear() {
            motionDetector.stop()
            isLandscape = false
            AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }
        
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    @StateObject static var motionDetector = MotionDetector(updateInterval: 0.01).started()
    static var previews: some View {
        HomeView()
            .environmentObject(motionDetector)
    }
}
