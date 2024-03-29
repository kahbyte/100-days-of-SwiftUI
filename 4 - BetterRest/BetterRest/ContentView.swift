//
//  ContentView.swift
//  BetterRest
//
//  Created by Kaue Sousa on 20/07/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = ContentViewConstants.sleepAmount
    @State private var wakeUp: Date = defaultWakeTime
    @State private var coffeeAmount: Int = 1
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingAlert: Bool = false
    
    @State private var bedTime: String = ""
    
    private var components = DateComponents()
    
    private static var defaultWakeTime: Date {
        var components: DateComponents = .init()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper(
                        "\(sleepAmount.formatted())",
                        value: $sleepAmount,
                        in: 4...12,
                        step: 0.25
                    )
                }
                
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    Picker("Cups", selection: $coffeeAmount) {
                        ForEach(0..<20) { amount in
                            Text(amount == 1 ? "1 cup" : "\(amount) cups")
                        }
                    }
                    
                    Text(bedTime)
                }
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage   )
            }

        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(
                wake: Double(hour + minutes),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )
            
            let sleeptime = wakeUp - prediction.actualSleep
            alertMessage = "\(sleeptime.formatted(date: .omitted, time: .shortened))"
            alertTitle = "Your ideal bedtime is"
            return "\(sleeptime.formatted(date: .omitted, time: .shortened))"
        }
        catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
            return "Error"
        }

//        showingAlert = true
    }
    
    private struct ContentViewConstants {
        static let sleepAmount = 8.0
        static let sleepRange = 4.0...12.0
        static let step = 0.25
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
