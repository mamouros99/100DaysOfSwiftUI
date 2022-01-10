//
//  ContentView.swift
//  BetterRest
//
//  Created by Tiago Mamouros on 10/01/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    
    func calculateBedtime() -> String{
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))

            let sleepTime = wakeUp - prediction.actualSleep
        
            return sleepTime.formatted(date: .omitted, time: .shortened)


        }
        catch{
            return "Error Calculating your bedtime"
        }
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section("When do you want to wake up?", content: {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                })
                
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                                
                    
                Picker("Coffe", selection: $coffeeAmount) {
                    ForEach(1..<21){
                        Text("\($0) Coffe")
                    }
                }
                
                Section("Best Sleeping Time") {
                    Text(calculateBedtime())
                        .font(.title)
                        .bold()
                }
            }
            .navigationTitle("BetterRest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
