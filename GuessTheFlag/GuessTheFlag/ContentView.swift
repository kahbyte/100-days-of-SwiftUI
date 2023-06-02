//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kaue Sousa on 01/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack {
            Button("Show alert") {
                showingAlert = true
            }
            .alert("Important message", isPresented: $showingAlert) {
                Button("Delete", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please, leave.")
            }

        }
    }
    
    func executeDelete() {
        print("now deleting...")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
