//
//  Charts.swift
//  SwiftUI4.0
//
//  Created by Adarsh Shukla on 26/11/22.
//

import SwiftUI
import Charts

//The Chart initializer takes in a list of Identifiable objects. This is why we make the WeatherData conform the Identifiable protocol.
struct Sale: Identifiable {
    var id: String = UUID().uuidString
    var sales: Int
    var time: String
    var day: String
}

class SalesViewModel: ObservableObject {
    @Published var dailySales: [Sale] = [
        .init(sales: 20, time: "11:00", day: "Monday"),
        .init(sales: 40, time: "12:00", day: "Wednesday"),
        .init(sales: 40, time: "1:00", day: "Tuesday"),
        .init(sales: 150, time: "2:00", day: "Monday"),
        .init(sales: 260, time: "3:00", day: "Saturday"),
        .init(sales: 80, time: "4:00", day: "Sunday"),
        .init(sales: 120, time: "5:00", day: "Friday"),
        .init(sales: 50, time: "6:00", day: "Friday"),
        .init(sales: 30, time: "7:00", day: "Sunday")
    ]
}


struct ChartsFramework: View {
    @ObservedObject var vm = SalesViewModel()
    var body: some View {
        VStack {
            Chart {
                ForEach(vm.dailySales) { dailySale in
                    BarMark(x: .value("Day", dailySale.day),
                             y: .value("Sales", dailySale.sales))
                    .interpolationMethod(.catmullRom)
                    //.foregroundStyle(.black)
                    .foregroundStyle(by: .value("Sales", dailySale.time))
                    
//                    AreaMark(x: .value("Day", dailySale.day),
//                             y: .value("Sales", dailySale.sales))
//                    .interpolationMethod(.catmullRom)
//                    .foregroundStyle(.white)
                }
            }
            .frame(width: 400, height: 400)
            .chartPlotStyle { plotArea in
                plotArea
                    .foregroundColor(.red)
                    .background {
                        //We can provide any View as a background.
                        LinearGradient(gradient: .init(colors: [Color.orange.opacity(0.6),Color.orange.opacity(0.5), Color.orange.opacity(0.3), Color.orange.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    }
            }
        }
    }
}

struct ChartsFramework_Previews: PreviewProvider {
    static var previews: some View {
        ChartsFramework()
    }
}


//Modifiers -
/*
 1. chartPlotStyle - returns us ChartPlotContent which is a view that represents a chart’s plot area. We can add modifiers to this View. This is applied to the chart.
 
 2. interpolationMethod - curvature of the line passing through the points. Various methods are -  cardinal
                    catmullRom
                    linear
                    monotone
                    stepStart
                    stepCenter
                    stepEnd
 This is applied to the marks.
 
 3. foregroundStyle(style) - provides the foreground styling to applied Mark. This dominates the case when both foregroundStyle and chartPlotStyle modifiers are applied. This applied to the mark. This modifier can be used to apply a different color for each line. You don’t have to specify the color. SwiftUI will automatically pick the color for you.
 */

