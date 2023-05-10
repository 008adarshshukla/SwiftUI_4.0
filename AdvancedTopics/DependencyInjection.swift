//
//  DependencyInjection.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 10/05/23.
//

import SwiftUI
import Combine

// PROBLEMS WITH SINGLETONS
// 1. Singleton's are GLOBAL
// 2. Can't customize the init!
// 3. Can't swap out dependencies

struct PostsModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostsModel], Error>
}

//MARK: Production Data service
class ProductionDataService: DataServiceProtocol {
        
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
//MARK: Mock Data service.
class MockDataService: DataServiceProtocol {
    
    let testData: [PostsModel]
    
    init(data: [PostsModel]?) {
        self.testData = data ?? [
            PostsModel(userId: 1, id: 1, title: "One", body: "one"),
            PostsModel(userId: 2, id: 2, title: "Two", body: "two"),
        ]
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
    
}

class DependencyInjectionViewModel: ObservableObject {
    
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)

    }
    
}

struct DependencyInjectionBootcamp: View {
    
    @StateObject private var vm: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray) { post in
                    Text(post.title)
                }
            }
        }
    }
}

struct DependencyInjectionBootcamp_Previews: PreviewProvider {
    
    //creating the instance at the very begining.
    static let mockDataService = MockDataService(data: [
        PostsModel(userId: 1234, id: 1234, title: "test", body: "test")
    ])
    
    static let productionDataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    
    static var previews: some View {
        DependencyInjectionBootcamp(dataService: productionDataService)
    }
}

/*
 Depedency Injection - Whenever we create a class or struct that has dependencies, instead of referencing the dependencies from within the class we can inject the dependency into the class or the struct thrrough the initializer.
 */

/*
 How does dependency Injection sove above problems -
 1. Now only those classes have access to DataService in which we inject it as the dependency. So it is not globally accessible to all classes and structs like Singletons.
 2. Initisers can now be customised.
 3. Now we can swap the dependencies (like passing mockDataService or productionDataService)
 */
