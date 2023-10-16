//
//  ContentView.swift
//  D19UnitConverter
//
//  Created by Pham Anh Tuan on 10/16/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0.0
    @State private var inputUnit = "Feet"
    @State private var outputUnit = "Feet"
    
    @FocusState private var inputValueIsFocused: Bool
    
    private let units = [
        "Feet": UnitLength.feet,
        "Inches": UnitLength.inches,
        "Meters": UnitLength.meters,
        "Kilometers": UnitLength.kilometers,
        "Centimeters": UnitLength.centimeters,
        "Deimeters": UnitLength.decimeters,
        "Millimeters": UnitLength.millimeters
    ]
    
    private var outputValue: String {
        let convertedInputValue = Measurement(value: inputValue, unit: units[inputUnit] ?? UnitLength.feet)
        let convertedOutputValue = convertedInputValue.converted(to: units[outputUnit] ?? UnitLength.feet)
        
        return convertedOutputValue.description
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputValueIsFocused)
                    
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(Array(units.keys), id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Output") {
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(Array(units.keys), id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Text(outputValue)
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                if inputValueIsFocused {
                    Button("Done") {
                        inputValueIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
