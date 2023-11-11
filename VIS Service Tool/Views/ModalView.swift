//
//  ModalView.swift
//  VIS Service Tool
//
//  Created by Matt Reid on 13/9/2022.
//

import SwiftUI

struct ModalView: View {
    @EnvironmentObject var motionDetector: MotionDetector
    @State var appear = false
    @State var appearBackground = false
    @State var viewState = CGSize.zero
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                viewState = value.translation
            }
            .onEnded { value in
                if value.translation.height > 300 {
                    dismissModal()
                } else {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                        viewState = .zero
                    }
                }
            }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(0.7))
                .onTapGesture { dismissModal() }
                .opacity(appear ? 1 : 0)
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                
                HelpView(dismissModal: { dismissModal() })
                
                    .rotationEffect(.degrees(viewState.width / 40))
                    .rotation3DEffect(.degrees(viewState.height / 20), axis: (x: 1, y: 0, z: 0), perspective: 1)
                    .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
                    .padding(20)
                    .offset(x: viewState.width, y: viewState.height)
                    .gesture(drag)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .offset(y: appear ? 0 : proxy.size.height)
            }
            
            Button {
                dismissModal()
            } label: {
                CloseButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            .offset(y: appear ? 0 : -100)
        }
        .onAppear {
            withAnimation(.spring()) {
                appear = true
            }
            withAnimation(.easeOut(duration: 2)) {
                appearBackground = true
            }
        }
        .onDisappear {
            withAnimation(.spring()) {
                appear = false
            }
            withAnimation(.easeOut(duration: 1)) {
                appearBackground = true
            }
        }
        .onChange(of: motionDetector.dismissModal) { _ in
            dismissModal()
        }
        
    }
}

struct ModalView_Previews: PreviewProvider {
    @StateObject static var motionDetector = MotionDetector(updateInterval: 0.01).started()
    static var previews: some View {
        ModalView()
            .environmentObject(motionDetector)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

extension ModalView {
    func dismissModal() {
        withAnimation {
            appear = false
            appearBackground = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            motionDetector.showModal = false
        }
    }
}



