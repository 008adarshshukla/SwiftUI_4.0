//
//  NavigationStack2Bootcamp.swift
//  SwiftUI4.0
//
//  Created by Adarsh Shukla on 06/12/22.
//

import SwiftUI

struct Book: Identifiable,Hashable {
    var name: String
    var price: Int
    var coverPage: Color
    var id: String {
        name
    }
    
    static var sample: [Book] = [
        .init(name: "Book1", price: 20, coverPage: .red),
        .init(name: "Book2", price: 25, coverPage: .blue),
        .init(name: "Book3", price: 15, coverPage: .orange)
    ]
}

struct NavigationStack2Bootcamp: View {
    
    //homogeneous
    //@State var path: [Book] = []
    //hetrogeneous
    @State var path = NavigationPath()
    @State var showNewScreen: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                NavigationLink(Book.sample[0].name, value: Book.sample[0].name)
                NavigationLink(Book.sample[1].name, value: Book.sample[1].price)
                NavigationLink(Book.sample[2].name, value: Book.sample[2].coverPage)
                NavigationLink("Book", value: Book.sample[2])
                
                Button {
                    //perform action and toggle a state property to
                    //also perform navigation simultaneously.
                    showNewScreen = true
                    
                } label: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.pink)
                }

                
            }
            .buttonStyle(.borderedProminent)
            .navigationDestination(for: String.self) { stringValue in
                Text(stringValue)
            }
            .navigationDestination(for: Int.self) { integerValue in
                Text("\(integerValue)")
            }
            .navigationDestination(for: Color.self) { colorValue in
                colorValue
                    .edgesIgnoringSafeArea(.all)
            }
            .navigationDestination(for: Book.self) { book in
                ZStack {
                    book.coverPage
                        .edgesIgnoringSafeArea(.all)
                    
                    Text(book.name)
                        .font(.largeTitle)
                }
            }
            .navigationDestination(isPresented: $showNewScreen) {
                Text("showing second screen")
            }
        }
    }
}

struct NavigationStack2Bootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack2Bootcamp()
    }
}

/*
 If we define the path as the array of Book object then all the NavigationLink which have value: parameter work but others do not work i.e the "Book" Navigation Link. others do not work because the path array stores only the object of Book. This leads to homogeneous path.
 
 To get an hetrogeneous path we can use intialise with the instance of the NavigationPath()
 */
