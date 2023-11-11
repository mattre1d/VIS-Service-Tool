//
//  Tab.swift
//  DesignCodeIOS15
//
//  Created by Matt Reid on 4/9/2022.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
    TabItem(text: "Home", icon: "house", tab: .home, color: Color("HxGN") ),
    TabItem(text: "Faults", icon: "stethoscope", tab: .faults, color: Color("HxGN")),
    TabItem(text: "Radar Yaw", icon: "arrow.left.and.right.righttriangle.left.righttriangle.right", tab: .radaryaw, color: Color("HxGN")),
    TabItem(text: "Radar Pitch", icon: "arrow.up.and.down.righttriangle.up.righttriangle.down", tab: .radarpitch, color: Color("HxGN")),
]

enum Tab: String {
    case home
    case faults
    case radaryaw
    case radarpitch
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
