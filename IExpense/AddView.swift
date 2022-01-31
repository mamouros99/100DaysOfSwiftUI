//
//  AddView.swift
//  IExpense
//
//  Created by Tiago Mamouros on 29/01/2022.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss

    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @ObservedObject var expenses : Expenses
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationView {
            Form{
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){ tp in
                        Text(tp)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save"){
                    dismiss()
                    expenses.items.append(ExpenseItem(name: name, type: type, amount: amount))
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
