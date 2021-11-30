//
//  ContentView.swift
//  BitoWeSplit
//
//  Created by Alberto Alegre Bravo on 30/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var totalCheck = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = totalCheck / 100 * tipSelection
        let grandTotal = totalCheck + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $totalCheck, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<9) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip percentages")
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                }
            }
            .navigationTitle("WeSplit APP")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    
                    Spacer()
                    
                    Button("Done") {
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
