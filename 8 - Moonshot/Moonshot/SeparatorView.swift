//
//  SeparatorView.swift
//  Moonshot
//
//  Created by Kaue Sousa on 09/10/23.
//

import SwiftUI

struct SeparatorView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct SeparatorView_Previews: PreviewProvider {
    static var previews: some View {
        SeparatorView()
    }
}
