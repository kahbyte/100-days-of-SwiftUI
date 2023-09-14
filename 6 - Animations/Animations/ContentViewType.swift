//
//  ContentViewType.swift
//  Animations
//
//  Created by Kaue Sousa on 14/09/23.
//

import SwiftUI

struct ContentViewType: View {
        @State private var isShowingRed = false

        var body: some View {
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)

                if isShowingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
            .onTapGesture {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
        
    }
    
}

struct ContentViewType_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewType()
    }
}
