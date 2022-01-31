//
//  ExpenseItem.swift
//  IExpense
//
//  Created by Tiago Mamouros on 29/01/2022.
//

import Foundation

struct ExpenseItem : Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

