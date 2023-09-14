//
//  ViewTransitions.swift
//  Animations
//
//  Created by Kaue Sousa on 14/09/23.
//

import SwiftUI

struct ViewTransitions: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct ViewTransitions_Previews: PreviewProvider {
    static var previews: some View {
        ViewTransitions()
    }
}
