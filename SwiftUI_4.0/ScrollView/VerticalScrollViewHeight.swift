//
//  VerticalScrollViewOffset.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 07/04/23.
//

import SwiftUI

struct VerticalScrollViewHeight: View {
    
    @State private var height: CGFloat = .zero
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                HStack {
                    Text("Adarsh")
                        .fontWeight(.black)
                        .font(.system(size: 30))
                    Text("\(height)")
                        .fontWeight(.black)
                        .font(.system(size: 30))
                }
                
                ScrollView(showsIndicators: true) {
                    VStack {
                        ForEach(0..<25, id: \.self) { i in
                            Text("Example \(i)")
                                .font(.title)
                                .id(i)
                        }
                    }
                    .background {
                        GeometryReader { geo in
                            Color.red
                                .preference(key: HeightPreferenceKey.self, value: geo.size.height)
                        }
                    }
                    .onPreferenceChange(HeightPreferenceKey.self) { value in
                        self.height = value
                    }
                }
                
            }
        }
    }
}



private struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct VerticalScrollViewOffset_Previews: PreviewProvider {
    static var previews: some View {
        VerticalScrollViewHeight()
    }
}
