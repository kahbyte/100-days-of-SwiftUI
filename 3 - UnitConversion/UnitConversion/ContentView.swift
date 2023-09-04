//
//  ContentView.swift
//  UnitConversion
//
//  Created by Kaue Sousa on 30/05/23.
//

import SwiftUI

struct ContentView: View {
    enum Temperatures: String, CaseIterable, Identifiable {
        var id: Self { self }
        
        case celsius = "ºC"
        case fahrenheit = "ºF"
        case kelvin = "ºK"
    }
    
    @State private var inputTemperature: Double = 0.0
    @State private var inputTemperatureType: Temperatures = .celsius
    @State private var outputUnit: Temperatures = .fahrenheit
    
    private var convertedTemperature: Double {
        convertTo(temperature: inputTemperature)
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        TextField("Temperature", value: $inputTemperature, format: .number)
                        Picker("", selection: $inputTemperatureType) {
                            ForEach(Temperatures.allCases) { temperature in
                                Text(temperature.rawValue)
                            }
                        }
                    }
                } header: {
                    Text("Initial temperature")
                }
                
                Section {
                    HStack {
                        Text("\(convertedTemperature.formatted())")
                        Picker("", selection: $outputUnit) {
                            ForEach(Temperatures.allCases) { temperature in
                                Text(temperature.rawValue)
                            }
                        }
                    }
                } header: {
                    Text("Converted temperature")
                }
            }
            .navigationTitle("Temperature Converter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func convertTo(temperature: Double) -> Double {
        var temperatureInCelsius: Double = 0.0
        
        switch inputTemperatureType {
        case .celsius:
            temperatureInCelsius = temperature
        case .fahrenheit:
            temperatureInCelsius = (temperature - 32) / 1.8
        case .kelvin:
            temperatureInCelsius = temperature - 273.15
        }
        
        switch outputUnit {
        case .celsius:
            return temperatureInCelsius
        case .fahrenheit:
            return (temperatureInCelsius * 1.8) + 32
        case .kelvin:
            return temperatureInCelsius + 273.15
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
