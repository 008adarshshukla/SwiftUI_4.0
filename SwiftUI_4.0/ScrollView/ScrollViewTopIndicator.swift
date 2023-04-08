//
//  ScrollViewTopIndicator.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 09/04/23.
//

import SwiftUI

struct ScrollViewTopIndicator: View {
    @StateObject private var viewModel = PaginationViewModel()
    @State var scrollViewOffset: CGFloat = 0
    @State var startOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: true, content: {
                VStack {
                    ForEach(viewModel.users, id: \.self) { user in
                        UserRowView(user: user)
                    }
                }
                .background (
                    GeometryReader { proxy -> Color in
                        DispatchQueue.main.async {
                            if startOffset == 0 {
                                self.startOffset = proxy.frame(in: .global).minY
                            }
                            
                            let offset = proxy.frame(in: .global).minY
                            self.scrollViewOffset = offset - startOffset
                            
                            print(self.scrollViewOffset)
                        }
                        return Color.clear
                    }
                        .frame(width: 0, height: 0)
                    ,alignment: .top
                )
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

struct ScrollViewTopIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewTopIndicator()
    }
}

/*
 In this Scroll View when the scrollViewOffset is 0 at the top
 */
