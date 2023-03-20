//
//  NvaigationStackBootcamp5.swift
//  SwiftUI4.0
//
//  Created by Adarsh Shukla on 22/12/22.
//

import SwiftUI

struct NvaigationStackBootcamp5: View {
    
    //homogeneous path.
    @State var stringNavigationPath = [String]()
    
    var body: some View {
        VStack {
            NavigationStack(path: $stringNavigationPath) {
                VStack {
                    Text("First")
                    NavigationLink("Go to Second screen", value: "First")
                        .navigationDestination(for: String.self) { _ in
                            Second()
                        }
                }
            }
            
            Text(stringNavigationPath.description)
        }
    }
}

struct Second: View {
    var body: some View {
        VStack {
            Text("Second")
            NavigationLink("Go to third screen", value: "Second")
                .navigationDestination(for: String.self) { _ in
                    Third()
                }
        }
    }
}

struct Third: View {
    var body: some View {
        VStack {
            Text("Third")
            NavigationLink("Go to fourth screen", value: "Third")
                .navigationDestination(for: String.self) { _ in
                    Fourth()
                }
        }
    }
}

struct Fourth: View {
    var body: some View {
        VStack {
            Text("Fourth")
            NavigationLink("Go to fifth screen", value: "Fourth")
                .navigationDestination(for: String.self) { _ in
                    Fifth()
                }
        }
    }
}

struct Fifth: View {
    var body: some View {
        VStack {
            Text("Fifth")
        }
    }
}


struct NvaigationStackBootcamp5_Previews: PreviewProvider {
    static var previews: some View {
        NvaigationStackBootcamp5()
    }
}

/*
 Note -
 1. Root view is not included in path array.
 */
