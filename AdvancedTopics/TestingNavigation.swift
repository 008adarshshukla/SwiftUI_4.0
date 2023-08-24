//
//  TestingNavigation.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 28/06/23.
//

import SwiftUI

enum Route {
    case first
    case second
    case third
    case fourth
    case fifth
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .first:
            TestingNavigation()
        case .second:
            SecondNaView()
        case .third:
            ThirdNaView()
        case .fourth:
            FourthNaView()
        case .fifth:
            FifthNaView()
        }
        
    }
}

struct TestingNavigation: View {
    @StateObject private var vm = NavigationPathManager2()
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    var body: some View {
        NavigationStack {
            VStack {
                Text("Screen 1")
                
                NavigationLink("Go to 2", value: Route.second)
            }
            .navigationDestination(for: Route.self) { route in
                route.view
            }
        }
        .environmentObject(vm)
    }
}

struct TestingNavigation_Previews: PreviewProvider {
    static var previews: some View {
        TestingNavigation()
    }
}

struct SecondNaView: View {
    var body: some View {
        VStack {
            Text("Screen 2")
            
            NavigationLink("Go to 3", value: Route.third)
        }
        .navigationDestination(for: String.self) { _ in
            ThirdNaView()
        }
    }
}

struct ThirdNaView: View {
    var body: some View {
        VStack {
            Text("Screen 3")
            
            NavigationLink("Go to 4", value: Route.fourth)
        }
        .navigationDestination(for: String.self) { _ in
            FourthNaView()
        }
    }
}

struct FourthNaView: View {
    var body: some View {
        VStack {
            Text("Screen 4")
            
            NavigationLink("Go to 5", value: Route.fifth)
        }
        .navigationDestination(for: String.self) { _ in
            FifthNaView()
        }
    }
}

struct FifthNaView: View {
    @EnvironmentObject var vm: NavigationPathManager2
    var body: some View {
        VStack {
            Text("Screen  5")
            Button {
                
            } label: {
                Text("Go to root")
            }

        }
    }
}

class NavigationPathManager2: ObservableObject {
    @Published var path = NavigationPath()
    
    func reset() {
        path = NavigationPath()//reinitilising to take us back to root View
    }
}
