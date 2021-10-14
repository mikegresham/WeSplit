//
//  ContentView.swift
//  WeSplit
//
//  Created by Michael Gresham on 12/10/2021.
//
//  My first SwiftUI Project - An app to split a bill between a group of people.

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPerctange = 2
    let tipPercentages = [10, 15 ,20, 25, 0]
    
    // MARK: Computed Properties
    
    var subTotal: Double {
        // Calculate the amount without tip
        Double(checkAmount) ?? 0
    }
    
    var tipAmount: Double {
        // Calculate the tip value
        let tipSelection = Double(tipPercentages[tipPerctange])

        return subTotal / 100 * tipSelection
    }
    
    var total: Double {
        // Calculate total (Amount including tip)
        subTotal + tipAmount
    }
    
    var totalPerPerson: Double {
        // Calculate total per person
        let peopleCount = Double(numberOfPeople) ?? 1
        let amountPerPerson = total / peopleCount
        
        return amountPerPerson
    }
    
    // MARK: UI
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: Text Fields
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                // MARK: Segmented Control (Tip Percentage)
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPerctange) {
                        ForEach (0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(.segmented)
                }
                
                // MARK: Bill (Summary of computed properties)
                
                Section(header: Text("Bill")) {
                    HStack {
                        Text("Subtotal")
                        Spacer()
                        Text("£\(subTotal, specifier: "%.2f")")
                            .foregroundColor(Color.gray)
                    }
                    HStack {
                        Text("Tip Amount \(tipPercentages[tipPerctange])%")
                        Spacer()
                        Text("£\(tipAmount, specifier: "%.2f")")
                            .foregroundColor(Color.gray)
                    }
                    HStack {
                        Text("Total")
                        Spacer()
                        Text("£\(total, specifier: "%.2f")")
                            .foregroundColor(Color.gray)
                    }
                }
                
                // MARK: Amount Per Person
     
                Section(header: Text("Amount per person")) {
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
