//
//  ContentView.swift
//  IExpense
//
//  Created by Tiago Mamouros on 24/01/2022.
//

import SwiftUI

struct row: View{
    let item : ExpenseItem
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            
            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
        }
    }
}


struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showAddExpense = false
    
    
    
    var body: some View {
        NavigationView {
            VStack{
                List{
                    ForEach(expenses.items){ item in
                        if item.type == "Personal"{
                            row(item: item)
                            .foregroundColor(textColour(item.amount))
                        }

                    }
                    .onDelete(perform: deleteItems)
                    
                }
                List{
                    ForEach(expenses.items){ item in
                        if item.type == "Business"{
                            row(item: item)
                            .foregroundColor(textColour(item.amount))
                        }

                    }
                    .onDelete(perform: deleteItems)
                    
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showAddExpense = true
                } label : {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAddExpense) {
            AddView(expenses: expenses)
        }

    }
    
    func deleteItems(at offsets: IndexSet) -> Void {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func textColour(_ amount : Double) -> Color{
        if amount < 10 {
            return .green
        }
        if amount < 100 {
            return .yellow
        } else {
            return .red
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
