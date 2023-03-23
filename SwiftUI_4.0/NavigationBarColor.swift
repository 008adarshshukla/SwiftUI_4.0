//
//  NavigationBarColor.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 23/03/23.
//

import SwiftUI

struct NavigationBarColor: View {
    var body: some View {
        NavigationStack {
            Text("Dashboard")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Cool Title")
                            .foregroundColor(.black)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.red, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct NavigationBarColor_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarColor()
    }
}
