//
//  NavigationStackBootcamp4.swift
//  SwiftUI4.0
//
//  Created by Adarsh Shukla on 22/12/22.
//


/*
 Uisng th navigation Path Property to create a custum back buttum
 */
import SwiftUI

struct NavigationStackBootcamp4: View {
    
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            NavigationLink("Go to second screen", value: "Second Screen")
                .navigationDestination(for: String.self) { stringValue in
                    SecondScreen2(path: $path)
                }
        }
    }
}

struct SecondScreen2: View {
    @Binding var path: NavigationPath
    var body: some View {
        VStack {
            NavigationLink("Go to third screen", value: 3)
                .navigationDestination(for: Int.self) { _ in
                    Text("Third Screen")
                }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    path.removeLast()
                } label: {
                    Image(systemName: "chevron.left")
                        .padding()
                        .background {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .shadow(color: .black.opacity(0.5), radius: 5)
                        }
                }

            }
        }
    }
}

struct NavigationStackBootcamp4_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackBootcamp4()
    }
}

/*
 1. Here a toolbaar item is acting as custom back button.
 2. To achieve this we have hidden the navigation bar back button and got the path as the binding variable.
 3. In the action of button we removed the last element in the path. This takes us  bask to the previous view.
 */
