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
    @State private var height: CGFloat = .zero
    @State private var scrollOffset: CGFloat = 0
    @State var cardHeight: CGFloat = 0
    @State var scrollViewOffset: CGFloat = 0
    @State var startOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: true, content: {
                VStack {
                    ForEach(viewModel.users, id: \.self) { user in
                        UserRowView(user: user, cardHeight: $cardHeight)
                            .onAppear {
                                if viewModel.shouldLoadNextData(name: user.name) {
                                    //Load further data
                                    Task {
                                        do {
                                            try await viewModel.loadNextBatch()
                                        }
                                    }
                                }
                            }
                    }
                }
            })
            .navigationTitle("Users")
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
        .task {
            do {
                try await viewModel.getUsers()
            } catch {
                print(error)
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

struct UserDetail: Codable, Hashable {
    let age: Int
    let earning: Int
    let name: String
}

@MainActor
class PaginationViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    let documentID: String = "A830AC94-E619-4E49-82D3-236B8D3A01BE"
    
    @Published var users: [UserDetail] = []
    
    @Published var lastDococument: QueryDocumentSnapshot!
    
    //Putting th data into the firestore.
    func addUsersToDatabase() throws {
        
        let users: [UserDetail] = [
            UserDetail(age: 28, earning: 50000, name: "John"),
            UserDetail(age: 35, earning: 75000, name: "Emily"),
            UserDetail(age: 21, earning: 25000, name: "Mike"),
            UserDetail(age: 42, earning: 100000, name: "Sarah"),
            UserDetail(age: 30, earning: 60000, name: "David"),
            UserDetail(age: 25, earning: 40000, name: "Amanda"),
            UserDetail(age: 39, earning: 90000, name: "Adam"),
            UserDetail(age: 32, earning: 65000, name: "Rachel"),
            UserDetail(age: 27, earning: 35000, name: "Daniel"),
            UserDetail(age: 45, earning: 120000, name: "Jessica"),
            UserDetail(age: 23, earning: 28000, name: "Sophie"),
            UserDetail(age: 37, earning: 82000, name: "Tom"),
            UserDetail(age: 29, earning: 55000, name: "Oliver"),
            UserDetail(age: 31, earning: 67000, name: "Amy"),
            UserDetail(age: 26, earning: 38000, name: "Ben"),
            UserDetail(age: 41, earning: 95000, name: "Linda"),
            UserDetail(age: 34, earning: 71000, name: "Harry"),
            UserDetail(age: 22, earning: 23000, name: "Karen"),
            UserDetail(age: 36, earning: 78000, name: "Mark"),
            UserDetail(age: 33, earning: 69000, name: "Melissa"),
            UserDetail(age: 24, earning: 32000, name: "James"),
            UserDetail(age: 38, earning: 86000, name: "Julia"),
            UserDetail(age: 43, earning: 105000, name: "Andrew"),
            UserDetail(age: 40, earning: 90000, name: "Catherine"),
            UserDetail(age: 20, earning: 20000, name: "Jake"),
            UserDetail(age: 28, earning: 51000, name: "Natalie"),
            UserDetail(age: 30, earning: 59000, name: "Greg"),
            UserDetail(age: 27, earning: 34000, name: "Isabel"),
            UserDetail(age: 44, earning: 110000, name: "Peter"),
            UserDetail(age: 25, earning: 42000, name: "Samantha")
        ]
        
        for user in users {
            try db.collection("PaginationUsers").document(user.name).setData(from: user)
        }
    }
    
    //getting users in batches (pagination)
    func getUsers() async throws{
        let querySnapshot = try await db.collection("PaginationUsers").order(by: "name").limit(to: 10).getDocuments()
        
        if !querySnapshot.documents.isEmpty {
            for document in querySnapshot.documents {
                let newUser = try document.data(as: UserDetail.self)
                self.users.append(newUser)
            }
        }
        
        self.lastDococument = querySnapshot.documents.last
    }
    
    func loadNextBatch() async throws {
        let querySnapshot = try await db.collection("PaginationUsers").order(by: "name").start(afterDocument: self.lastDococument).limit(to: 5).getDocuments()
        
        if !querySnapshot.documents.isEmpty {
            for document in querySnapshot.documents {
                let newUser = try document.data(as: UserDetail.self)
                self.users.append(newUser)
            }
        }
        
        self.lastDococument = querySnapshot.documents.last
    }
    
    func shouldLoadNextData(name : String) -> Bool {
        if name == users[users.count - 2].name {
            return true
        }
        return false
    }
    
}

struct UserRowView: View {
    
    let user: UserDetail
    @Binding var cardHeight: CGFloat
    
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
                
                Text("$ \(user.earning)")
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

/*
 Before adding the object of the struct to the field in documnet we need to encode it to the firebase types.
 
 let encodedNewTextPostId = try! Firestore.Encoder().encode(newTextPostId)
 here newTextPostId is the object of the struct.
 */

/*
 Note - Pagination means getting limited number of documents.
 */

/*
 Apply to VStack in Scroll View
 
 //                .background (
 //                    GeometryReader { proxy -> Color in
 //                        DispatchQueue.main.async {
 //                            if startOffset == 0 {
 //                                self.startOffset = proxy.frame(in: .global).minY
 //                            }
 //
 //                            let offset = proxy.frame(in: .global).minY
 //                            self.scrollViewOffset = offset - startOffset
 //
 //                            print(self.scrollViewOffset)
 //                        }
 //                        return Color.clear
 //                    }
 //                        .frame(width: 0, height: 0)
 //                    ,alignment: .top
 //                )
 
 This gives scroll view offset when the scroll view is at the top.
 */


