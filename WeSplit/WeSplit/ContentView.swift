//
//  ContentView.swift
//  WeSplit
//
//  Created by Tiago Mamouros on 05/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    let tipPercentages = [0, 0.1, 0.15, 0.20, 0.25]
    
    @State private var total = 0.0
    @State private var people = 2
    @State private var tipPercentage = 0.0
    
    @FocusState private var amountIsFocused: Bool
    
    var totalAndTip: Double {
        (total * (1 + tipPercentage))
    }
    
    
    var totalPerPerson: Double {
        return totalAndTip / Double(people+2)
    }
    
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var body: some View {
        NavigationView {
            Form{
                
                Section {
                    TextField("Amount", value: $total, format: localCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Text("Amount total: \(total, format: localCurrency)")
                    
                    Picker("Number of people", selection: $people){
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0, format: .percent)")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("Tip u want to give")
                }
                
                Section{
                    Text(totalPerPerson, format: localCurrency)
                } header: {
                    Text("Amount per person")
                }
                
                Section{
                    Text(totalAndTip, format: localCurrency)
                        .foregroundColor(tipPercentage == 0 ? .red : .blue)
                } header: {
                    Text("Total with Tip")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
