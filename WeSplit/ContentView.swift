//
//  ContentView.swift
//  WeSplit
//
//  Created by Michael Gresham on 12/10/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPerctange = 2
    let tipPercentages = [10, 15 ,20, 25, 0]
    
    var totalPerPerson: Double {
        // Calculate total per person
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPerctange])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of People", selection:  $numberOfPeople) {
                        ForEach (2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPerctange) {
                        ForEach (0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(.segmented)
                }
     
                Section {
                    Text("£\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
