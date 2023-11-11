//
//  StepsView.swift
//  VIS Service Tool
//
//  Created by Matt Reid on 13/9/2022.
//

import SwiftUI

struct HelpView: View {
    @State var appear = [false, false, false]
    var dismissModal: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Steps:")
                .font(.title).bold()
            
            Text("1. Place phone against level surface. Eg. Bumper.")
                .font(.footnote)
                .foregroundColor(.primary.opacity(0.8))

            Text("2. Tap Screen to calibrate zero position.")
                .font(.footnote)
                .foregroundColor(.primary.opacity(0.8))

            Text("3. Place phone against Tracking Radar. Live angle will be displayed.")
                .font(.footnote)
                .foregroundColor(.primary.opacity(0.8))
  
            Text("4. Adjust Tracking Radar until desired angle is reached.")
                .font(.footnote)
                .foregroundColor(.primary.opacity(0.8))

        }
        .coordinateSpace(name: "stack")
        .padding(30)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .onAppear { animate() }
    }
    
    func animate() {
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.2)) {
            appear[0] = true
        }
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8).delay(0.6)) {
            appear[2] = true
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView(dismissModal: {})
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
