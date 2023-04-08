//
//  Pagination.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 08/04/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Pagination: View {
    
    @StateObject private var viewModel = PaginationViewModel()
    
    var body: some View {
        NavigationStack {
            Text("Hello")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add") {
                            
                                do {
                                    try viewModel.addUsersToDatabase()
                                } catch {
                                    print("error putting data into database.")
                                }
                            
                        }
                        .buttonStyle(.bordered)
                    }
                }
        }
        
        
    }
}

struct Pagination_Previews: PreviewProvider {
    static var previews: some View {
        Pagination()
    }
}

struct AllUsers: Codable, Identifiable {
    @DocumentID var id: String?
    let users: [UserDetail]
}

struct UserDetail: Codable {
    let name: String
    let age: Int
    let earning: Float
}

class PaginationViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    let documentID: String = UUID().uuidString
    
    @Published var users: [UserDetail] = []
    
    //Putting th data into the firestore.
    func addUsersToDatabase() throws {
        let users: [UserDetail] = [
            UserDetail(name: "John", age: 27, earning: 50000.0),
            UserDetail(name: "Emily", age: 34, earning: 60000.0),
            UserDetail(name: "Mike", age: 22, earning: 45000.0),
            UserDetail(name: "Jessica", age: 30, earning: 80000.0),
            UserDetail(name: "Chris", age: 25, earning: 55000.0),
            UserDetail(name: "Sarah", age: 29, earning: 65000.0),
            UserDetail(name: "David", age: 26, earning: 52000.0),
            UserDetail(name: "Olivia", age: 31, earning: 75000.0),
            UserDetail(name: "Jacob", age: 28, earning: 58000.0),
            UserDetail(name: "Grace", age: 23, earning: 48000.0),
            UserDetail(name: "Ethan", age: 35, earning: 90000.0),
            UserDetail(name: "Ava", age: 27, earning: 52000.0),
            UserDetail(name: "Noah", age: 24, earning: 56000.0),
            UserDetail(name: "Isabella", age: 32, earning: 72000.0),
            UserDetail(name: "Luke", age: 26, earning: 51000.0),
            UserDetail(name: "Sophia", age: 29, earning: 68000.0),
            UserDetail(name: "Caleb", age: 28, earning: 59000.0),
            UserDetail(name: "Chloe", age: 25, earning: 54000.0),
            UserDetail(name: "Daniel", age: 33, earning: 67000.0),
            UserDetail(name: "Madison", age: 27, earning: 58000.0),
            UserDetail(name: "Matthew", age: 31, earning: 71000.0),
            UserDetail(name: "Ella", age: 24, earning: 50000.0),
            UserDetail(name: "Liam", age: 26, earning: 53000.0),
            UserDetail(name: "Natalie", age: 30, earning: 65000.0),
            UserDetail(name: "Mason", age: 28, earning: 62000.0),
            UserDetail(name: "Avery", age: 23, earning: 47000.0),
            UserDetail(name: "Owen", age: 34, earning: 78000.0),
            UserDetail(name: "Lily", age: 27, earning: 55000.0),
            UserDetail(name: "Gabriel", age: 25, earning: 570)
        ]
//        //conveting each item to the dictionary.
//        let usersDictionary = allUsers.map{
//            $0.toDict()
//        }
        
        let allUsers = AllUsers(users: users)
        try db.collection("PaginationUsers").document(documentID).setData(from: allUsers)
    }
    
//    func getUsers() async throws {
//        db.collection("PaginationUsers").document(documentID).get
//    }
    
}

struct UserRowView: View {
    
    let user: UserDetail
    
    var body: some View {
        VStack {
            HStack {
                Text(user.name)
                    .font(.system(size: 30))
                    .bold()
                Spacer()
            }
            HStack {
                Text("\(user.age) years")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("$ \(String(format: "%.2f", user.earning))")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.black.opacity(0.1))
        }
        .padding(.horizontal)
    }
}

extension UserDetail {
    func toDict() -> [String: Any] {
        return ["name": name, "age": age, "earning": earning]
    }
}

/*
 Before adding the object of the struct to the field in documnet we need to encode it to the firebase types.
 
 let encodedNewTextPostId = try! Firestore.Encoder().encode(newTextPostId)
 here newTextPostId is the object of the struct.
 */


