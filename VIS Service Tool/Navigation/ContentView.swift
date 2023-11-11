//
//  ContentView.swift
//  DesignCodeIOS15
//
//  Created by Matt Reid on 4/9/2022.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isLandscape") var isLandscape = false
    @State var selectedTab: Tab = .home
    @State var color: Color = Color("HxGN")
    @State var tabItemWidth: CGFloat = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Group {
                
                switch selectedTab {
                case .home:
                    HomeView()
                case .faults:
                    FaultsView()
                case .radaryaw:
                    YawView()
                        .transition(.forwardslide)
                case .radarpitch:
                    PitchView()
                        .transition(.backslide)
                }
            }
            .padding(.bottom, isLandscape ? 78 : 55)
            .ignoresSafeArea(.container, edges: .bottom)
          
            tabbar
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var tabbar: some View {
        HStack {
            buttons
        }
        .padding(.horizontal, 8)
        .padding(.top, isLandscape ? 4 : 8)
        .frame(height: isLandscape ? 55 : 78, alignment: .top)
        .background(.regularMaterial)
        .overlay(
            overlay
                .padding(.horizontal, 8)
        )
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
    
    var buttons: some View {
        ForEach(tabItems) { item in
            Button {
                withAnimation() {
                    selectedTab = item.tab
                }
            } label: {
                
                if isLandscape {
                    HStack {
                        Image(systemName: item.icon)
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .frame(width: 44, height: 29)
                        Text(item.text)
                            .font(.caption2)
                            .lineLimit(1)
                            .padding(.top, -5)
                    }
                    .frame(maxWidth: .infinity)
                    
                } else {
                    VStack {
                        Image(systemName: item.icon)
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .frame(width: 44, height: 29)
                        Text(item.text)
                            .font(.caption2)
                            .lineLimit(1)
                            .padding(.top, -5)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                
                
            }
            .foregroundStyle(selectedTab == item.tab ? Color("HxGN") : .secondary)
            .overlay(
                GeometryReader { proxy in
                    Color.clear.preference(key: TabPreferenceKey.self, value: proxy.size.width)
                }
            )
            .onPreferenceChange(TabPreferenceKey.self) {
                value in
                tabItemWidth = value - 10
            }
        }
        
    }
    
    var overlay: some View {
        HStack {
            if selectedTab == .radarpitch { Spacer() }
            if selectedTab == .faults { Spacer() }
            if selectedTab == .radaryaw {
                Spacer()
                Spacer()
            }
            Rectangle()
                .fill(Color("HxGN"))
                .frame(width: tabItemWidth, height: 2.5)
                .cornerRadius(3)
                .frame(maxHeight: .infinity, alignment: .top)
            if selectedTab == .home { Spacer() }
            if selectedTab == .faults {
                Spacer()
                Spacer()
            }
            if selectedTab == .radaryaw { Spacer() }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var motionDetector = MotionDetector(updateInterval: 0.01).started()
    static var previews: some View {
        ContentView()
            .environmentObject(motionDetector)
        
    }
}


extension AnyTransition {
    
    static var forwardslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .leading),
            removal: .move(edge: .leading))}
    
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .trailing))}
}

