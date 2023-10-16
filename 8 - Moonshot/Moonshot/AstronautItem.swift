//
//  AstronautItem.swift
//  Moonshot
//
//  Created by Kaue Sousa on 09/10/23.
//

import SwiftUI

struct AstronautItem: View {
    let crewMember: MissionView.CrewMember
    
    var body: some View {
        HStack {
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.white, lineWidth: 1)
                )
            
            VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                    .foregroundColor(.white)
                    .font(.headline)
                Text(crewMember.role)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
}
