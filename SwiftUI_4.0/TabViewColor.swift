//
//  TabViewColor.swift
//  SwiftUI_4.0
//
//  Created by Adarsh Shukla on 23/03/23.
//

import SwiftUI

struct TabViewColor: View {
    var body: some View {
        TabView {
            Text("Home")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.yellow, for: .tabBar)
            
            Text("Search")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.yellow, for: .tabBar)
            
            Text("Notification")
                .tabItem {
                    Label("Notification", systemImage: "bell")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.yellow, for: .tabBar)
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.yellow, for: .tabBar)
            
        }
    }
}

struct TabViewColor_Previews: PreviewProvider {
    static var previews: some View {
        TabViewColor()
    }
}

/*
 1. In iOS 16, SwiftUI got a way to change the bottom tab bar (TabView) background color with the new modifier, .toolbarBackground
 2. To change a tab bar background color in SwiftUI, you apply toolbarBackground modifier to the child view of TabView. Make sure you apply toolbarBackground to a child view, not a TabView.
 3. toolbarBackground accepts two parameters.
     1. ShapeStyle: The style to display as the background of the bar.
     2. ToolbarPlacement: The bars to place the style in. Since we want to change the color for a tab bar, we will set this to .tabBar.
 4. There are two things that you should be aware of.
     1. The background can be invisible even we set a color to it
     2. The background only applied to the modified tab when it is active
 5. By default, a tab bar background color will show/hide automatically based on the content of a child view, e.g., the tab bar background will show when the child content goes behind the tab view. We can override this behavior with the .toolbarBackground modifier.
 6. To control a tab view background color visibility, we need help from another modifier, .toolbar. Using this modifier, you can force a tab view to always be visible.
 7. If we apply toolbarBackground to the first tab, the second tab will still be the same. So we need to apply toolbaar color to all the child Views.
 
 8. To apply background color for all tabs, you can choose either one of these two methods.
     1. Apply toolbarBackground to all child views.
     2. Use Group.
 */
