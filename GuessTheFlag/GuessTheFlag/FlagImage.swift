//
//  FlagImage().swift
//  GuessTheFlag
//
//  Created by Kaue Sousa on 03/07/23.
//

import SwiftUI

struct FlagImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
    }
}
