//
//  FaultsView.swift
//  L9 Service Tool
//
//  Created by Matt Reid on 11/9/2022.
//

import SwiftUI

struct FaultsView: View {
    @AppStorage("isLandscape") var isLandscape = false
    @EnvironmentObject var motionDetector: MotionDetector
    
    var body: some View {
        
        NavigationView {
            List {
                
                ForEach (faultItems.indices, id: \.self) { index in
                    HStack {
                        Text(faultItems[index].hexCode)
                            .padding(.horizontal)
                        Text(faultItems[index].faultDescription)
                            .padding(.horizontal)
                    }
                    .listRowSeparatorTint(Color("LightBlue"))
                    .listStyle(.automatic)
                }
            }
            .navigationTitle("L9 Fault Codes")
            .padding(.bottom)
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

struct FaultsView_Previews: PreviewProvider {
    @StateObject static var motionDetector = MotionDetector(updateInterval: 0.01).started()
    static var previews: some View {
        FaultsView()
            .environmentObject(motionDetector)
            .previewInterfaceOrientation(.portrait)
        FaultsView()
            .preferredColorScheme(.dark)
            .environmentObject(motionDetector)
    }
}
