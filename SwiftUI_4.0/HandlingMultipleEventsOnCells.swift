//
//  HandlingMultipleEventsOnCells.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 20/03/23.
//

import SwiftUI

enum ReminderCellEvents {
    case onChecked(Int)
    case onDelete(Int)
}

struct ReminderCellView: View {
    
    let index: Int
    let event: (ReminderCellEvents) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "square")
                .onTapGesture {
                    event(.onChecked(index))
                }
            Text("Reminder \(index)")
            Spacer()
            Image(systemName: "trash")
                .onTapGesture {
                    event(.onDelete(index))
                }
        }
    }
}

struct HandlingMultipleEventsOnCells: View {
    var body: some View {
        List(1...20, id: \.self) { index in
            ReminderCellView(index: index) { event in
                switch event {
                case .onChecked(let index):
                    //do something
                    print("checked \(index)")
                case .onDelete(let index):
                    //do something
                    print("deleted \(index)")
                }
            }
        }
    }
}

struct HandlingMultipleEventsOnCells_Previews: PreviewProvider {
    static var previews: some View {
        HandlingMultipleEventsOnCells()
    }
}

/*
 Tips to make ReminderCellView Reusable.
 1. Pass functions that needs to be performed as parameters to view instaed of hardcoding
 2. There can be multiple functions which can be grouped under cases.
 */
