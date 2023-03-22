//
//  DisclosureGroup.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 22/03/23.
//

import SwiftUI

struct DisclosureGroupBootcamp: View {
    @State private var revealDetails = false

        var body: some View {
            VStack {
                DisclosureGroup("Show Terms", isExpanded: $revealDetails) {
                    Text("Long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here long terms and conditions here.")
                }
            }
        }
}

struct DisclosureGroupBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureGroupBootcamp()
    }
}

/*
 SwiftUI has a dedicated DisclosureGroup view that presents a disclosure indicator and contains content inside. In its simplest form it can be controlled entirely by the user, but you can also bind it to a Boolean property to determine programmatically whether its content is currently visible or not.
 */
