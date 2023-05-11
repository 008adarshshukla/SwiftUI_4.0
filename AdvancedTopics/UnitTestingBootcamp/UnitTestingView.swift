//
//  UnitTestingView.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 11/05/23.
//

import SwiftUI



struct UnitTestingView: View {
    
    @StateObject private var viewModel: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        _viewModel = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(viewModel.isPremium.description)
    }
}

struct UnitTestingView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingView(isPremium: true)
    }
}

/*
 1. Unit Testing -
 - tests the business logic in the application.
 
 2. UI Testing -
 - tests the UI of the application.
 */
