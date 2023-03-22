//
//  GuageBootcamp.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 22/03/23.
//

import SwiftUI

struct GuageBootcamp: View {
    
    @State var speed: Float = 60.0
    let gradient = Gradient(colors: [.blue, .green, .pink])
    
    var body: some View {
        VStack {
            
            Gauge(value: 60.0, in: 0.0...100.0) {
                Text("Speed")
                    .foregroundColor(.yellow)
            } currentValueLabel: {
                Text(speed, format: .number)
                    .foregroundColor(.yellow)
            } minimumValueLabel: {
                Text("0")
                    .foregroundColor(.yellow)
            } maximumValueLabel: {
                Text("100")
                    .foregroundColor(.yellow)
            }
            .gaugeStyle(.accessoryCircular)
            .tint(gradient)
            
            
            Spacer()
            
            Gauge(value: 60.0, in: 0.0...100.0) {
                Text("Speed")
            } currentValueLabel: {
                Text(speed, format: .number)
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(.red)
            
            Spacer()
            
            Gauge(value: 60.0, in: 0.0...100.0) {
                Text("Speed")
            } currentValueLabel: {
                Text(speed, format: .number)
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            }
            .gaugeStyle(.accessoryLinear)
            
            Spacer()
            
            Gauge(value: 60.0, in: 0.0...100.0) {
                Text("Speed")
            } currentValueLabel: {
                Text(speed, format: .number)
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            }
            .gaugeStyle(.accessoryLinearCapacity)
            
            Group {
                Spacer()
                
                Gauge(value: 60.0, in: 0.0...100.0) {
                    Text("Speed")
                } currentValueLabel: {
                    Text(speed, format: .number)
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("100")
                }
                .gaugeStyle(.automatic)
                
                Spacer()
                
                Gauge(value: 60.0, in: 0.0...100.0) {
                    Text("Speed")
                        .foregroundColor(.yellow)
                } currentValueLabel: {
                    Text(speed, format: .number)
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("100")
                }
                .gaugeStyle(.linearCapacity)
            }
        }
    }
}

struct GuageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GuageBootcamp()
    }
}

/*
 We can think of a Gauge view as a combination of ProgressView and a Slider.
 It can present a value within a range like a ProgressView.
 But it can have a range outside 0 and 1 and a label like a Slider.

 Its simplest form is very similar to ProgressView.
 */
