//
//  test.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 14/04/23.
//

import SwiftUI

struct test: View {
    @State private var showSheet = false
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                showSheet = true
            }
            .sheet(isPresented: $showSheet) {
                Text("Sheet")
                    .onAppear {
                        print("appeared")
                    }
            }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
