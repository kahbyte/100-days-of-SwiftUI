//
//  ContentView.swift
//  Navigation
//
//  Created by Kaue Sousa on 09/11/23.
//

import SwiftUI

struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}

struct ContentView: View {
    @State private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i)
                }
        }
    }
}

struct DetailView: View {
    var number: Int

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
