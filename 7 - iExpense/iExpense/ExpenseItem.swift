//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Kaue Sousa on 22/09/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = .init()
    let name: String
    let type: String
    let amount: Double
}
