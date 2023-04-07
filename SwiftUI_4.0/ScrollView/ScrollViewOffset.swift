//
//  ScrollViewOffset.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 08/04/23.
//

import SwiftUI

struct ScrollViewOffset: View {
    
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                LazyVStack {
                    Color.red.frame(width: 0, height: 0)
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                            }
                        )
                    ForEach(0..<50, id: \.self) { index in
                        Text("Row \(index)")
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                    }
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    self.scrollOffset = value
                }
            }
            .overlay {
                HStack {
                    Spacer()
                    Text("\(scrollOffset)")
                        .bold()
                }
            }
        }
    }
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct ScrollViewOffset_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffset()
    }
}
