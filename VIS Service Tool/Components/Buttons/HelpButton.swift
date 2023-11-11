//
//  HelpButton.swift
//  VIS Service Tool
//
//  Created by Matt Reid on 13/9/2022.
//

import SwiftUI

struct HelpButton: View {
    var body: some View {
        Image(systemName: "questionmark")
            .font(.system(size: 17, weight: .bold))
            .foregroundColor(.secondary)
            .padding(8)
            .background(.ultraThinMaterial, in: Circle())
//            .backgroundStyle(cornerRadius: 18)
    }
}

struct HelpButton_Previews: PreviewProvider {
    static var previews: some View {
        HelpButton()
    }
}
