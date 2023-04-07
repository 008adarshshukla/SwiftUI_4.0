//
//  GenericViewBuilder.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 07/04/23.
//

import SwiftUI

struct GenericViewBuilder: View {
    
    @State private var value: Int = 0
    
    var body: some View {
        FirstView(title: "Hello", value: $value) {
            //This goes as content.
            Text("Adarsh")
                .foregroundColor(.red)
        }
    }
}

struct GenericViewBuilder_Previews: PreviewProvider {
    static var previews: some View {
        GenericViewBuilder()
    }
}

struct FirstView <Content: View>: View {
    var title: String
    @Binding var value: Int //type in the init will be Binding<Color>
    var content: Content
    
    init(title: String, value: Binding<Int>, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self._value = value
        self.content = content()
    }
    
    var body: some View {
        VStack {
            Text("title")
                .foregroundColor(.blue)
            content
            Button("press me") {
                print("gh")
            }
            .buttonStyle(.bordered)

        }
    }
}

/*
 Passing binding parameters to the generic ViewBuilder View.
 */

/*
 Important -
 In this code snippet, the underscore sign before the value property in the init method is used to create a two-way binding to the variable that is passed as a parameter to the value property.

 When a Binding type is declared, Swift generates a property that is prefixed with an underscore character (e.g., _value), which is the actual storage for the property. The property without the underscore character is a computed property that provides a read-only view of the storage.

 By using the underscore character before the value property in the init method, we are directly accessing the underlying storage of the Binding property instead of its read-only computed property. This is necessary because the Binding type requires two-way communication between the view and the source of truth (in this case, the variable that is passed as a parameter), and we need to be able to modify the source of truth from within the view.
 */
