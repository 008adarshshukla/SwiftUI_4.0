//
//  NavigationStackBootcamp3.swift
//  SwiftUI4.0
//
//  Created by Adarsh Shukla on 06/12/22.
//

import SwiftUI
import Charts

struct Country: Identifiable, Hashable {
    var name: String
    var flag: String
    var population: Int
    var cities: [City]
    var id: String {
        name
    }
    
    static var sample: [Country] {
        [
            Country(name: "Canada", flag: "🇨🇦", population: 36991981, cities: City.all.filter{$0.country == "Canada"}),
            Country(name: "United States", flag: "🇺🇸", population: 332278200, cities: City.all.filter{$0.country == "United States"}),
            Country(name: "United Kingdom", flag: "🇬🇧", population: 67886004, cities: City.all.filter{$0.country == "United Kingdom"}),
            Country(name: "France", flag: "🇫🇷", population: 67413000, cities: City.all.filter{$0.country == "France"}),
            Country(name: "Mexico", flag: "🇲🇽", population: 128830, cities:  City.all.filter{$0.country == "Mexico"}),
        ]
    }
}


struct CountryListView: View {
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    @StateObject var route = NavigationPathManager()
    var body: some View {
        NavigationStack(path: $route.path) {
            List(Country.sample) { country in
                NavigationLink(value: country) {
                    HStack {
                        Text(country.flag)
                        Text(country.name)
                    }
                }
            }
            .navigationDestination(for: Country.self) { country in
                CountryView(country: country)
            }
            .navigationTitle("Countries")
        }
        .environmentObject(route)
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView()
    }
}

struct CountryView: View {
    var country: Country
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(country.flag)
                Text(country.name)
            }
            .font(.largeTitle)
            HStack {
                Spacer()
                Text("Population: \(country.population)")
            }
            List(country.cities) { city in
                NavigationLink(value: city) {
                    Text(city.name)
                }
            }
        }
        .padding()
        .navigationTitle("Country")
        .navigationDestination(for: City.self) { city in
            CityView(city: city)
        }
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CountryView(country: Country.sample[2])
        }
    }
}

struct CityView: View {
    
    @EnvironmentObject var route: NavigationPathManager
    
    let city: City
    var body: some View {
        VStack {
            ZStack {
                if city.isCapital {
                    Text("🌟")
                        .font(.system(size: 200))
                }
                HStack {
                    Text("\(city.name) (\(city.country))")
                        .font(.title2)
                }
            }
            .frame(height: 220)
            Chart(city.fellowCities) { city in
                BarMark(x: .value("City", city.name),
                        y: .value("Population", city.population))
                .foregroundStyle(by: .value("City", city.name))
            }
            .chartLegend(.hidden)
            .padding()
            
            Button {
                route.reset()
            } label: {
                Text("Move to root View")
            }
            .buttonStyle(.borderedProminent)

        }
        .navigationTitle("City")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CityView(city: Country.sample[2].cities[0])
                .environmentObject(NavigationPathManager())
        }
    }
}


struct City: Identifiable, Hashable {
    var name: String
    var country: String
    var isCapital: Bool
    var population: Int
    var id: String {
        name
    }
    
    static var all: [City] {
        [
            City(name: "Vancouver", country: "Canada", isCapital: false, population:  2632000),
            City(name: "Victoria", country: "Canada", isCapital: false, population: 394000),
            City(name: "Toronto", country: "Canada", isCapital: false, population: 6313000),
            City(name: "Ottawa", country: "Canada", isCapital: true, population: 1433000),
            City(name: "Seattle", country: "United States", isCapital: false, population: 4102100),
            City(name: "Denver", country: "United States", isCapital: false, population: 2897000),
            City(name: "San Francisco", country: "United States", isCapital: false, population: 3318000),
            City(name: "Washington", country: "United States", isCapital: true, population: 5434000),
            City(name: "London", country: "United Kingdom", isCapital: true, population: 95410000),
            City(name: "Glasgow", country: "United Kingdom", isCapital: false, population: 1689000),
            City(name: "Cardiff", country: "United Kingdom", isCapital: false, population: 485000),
            City(name: "Leeds", country: "United Kingdom", isCapital: false, population: 780000),
            City(name: "Edinburgh", country: "United Kingdom", isCapital: false, population: 548000),
            City(name: "Belfast", country: "United Kingdom", isCapital: false, population: 630000),
            City(name: "Lyon", country: "France", isCapital: false, population: 1748000),
            City(name: "Paris", country: "France", isCapital: true, population: 2140000),
            City(name: "Marseille", country: "France", isCapital: false, population: 1620000),
            City(name: "Toulon", country: "France", isCapital: false, population: 584000),
            City(name: "Nice", country: "France", isCapital: false, population: 945000),
            City(name: "Tijuana", country: "Mexico", isCapital: false, population: 2221000),
            City(name: "Mexico City", country: "Mexico", isCapital: true, population: 22085000),
            City(name: "Cancun", country: "Mexico", isCapital: false, population: 998000),
            City(name: "Monterrey", country: "Mexico", isCapital: false, population: 1135000),
            City(name: "Iztapalapa", country: "Mexico", isCapital: false, population: 1815000),
            City(name: "Puebla", country: "Mexico", isCapital: false, population: 1434000),
            City(name: "Chihuahua", country: "Mexico", isCapital: false, population: 809232)
        ]
    }
    
    var fellowCities: [City] {
        Self.all.filter {$0.country == country}
    }
}


class NavigationPathManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func reset() {
        path = NavigationPath()//reinitilising to take us back to root View
    }
}
