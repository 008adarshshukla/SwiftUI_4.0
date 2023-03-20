//
//  NavigationStack.swift
//  SwiftUI4.0
//
//  Created by Adarsh Shukla on 02/12/22.
//

import SwiftUI

struct NavigationStackBootcamp: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(value: "Value Provided") {
                    Text("Move to second screen.")
                        .buttonStyle(.bordered)
                    
                }
                .buttonStyle(.bordered)
                
                VStack {
                    NavigationLink(value: "New Value") {
                        Text("Move to third screen.")
                            .buttonStyle(.bordered)
                        
                    }
                    .buttonStyle(.bordered)
                }
            }
            .navigationDestination(for: String.self) { value in
                SecondScreen(value: value)
            }
        }
    }
}

struct SecondScreen: View {
    let value: String
    var body: some View {
//        ZStack {
//            Color.red
//                .edgesIgnoringSafeArea(.all)
//        }
        Text(value)
    }
}

struct NavigationStackBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackBootcamp()
    }
}

//MARK: Points to remember -
/*
 1. The type that is to be placed in value: parameter of NavigationLink should be hashable.
 2. NavigationLink's value: parameter must have its data type mentioned in navigationDestination's for: parameter
 3. navigationDestination can address to multiple navigationLinks when the value: parameter has the same type as mentiond in the for: parameter of the navigationDestination
 4. navigationDestination should be placed within the navigation stack.
 5. Don't put navigation destination into a loop.
 6. NaviagtionLinks can be stylised by button styles.
 7. The value entered in value: parameter of NaviagtionLink is passed to closure in navigation destination.
 8. Cannot use condtional logic on the value obtained in closure of navigationDestination.
 */
