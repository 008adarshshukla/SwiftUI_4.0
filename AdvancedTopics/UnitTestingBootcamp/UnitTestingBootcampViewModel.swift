//
//  File.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 11/05/23.
//

import SwiftUI

class UnitTestingBootcampViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
}
