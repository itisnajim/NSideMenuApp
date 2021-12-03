//
//  ContentView.swift
//  NSideMenuApp
//
//  Created by Najim on 12/1/21.
//

import SwiftUI
import NSideMenu

struct ContentView: View {
    @State var selectedView = "Home"
    
    @StateObject var options = NSideMenuOptions(style: .slideAbove, side: .leading, width: 220, showSkeletonStack: false, skeletonStackColor: .white, cornerRaduisIfNeeded: 16, rotationDegreeIfNeeded: 8, onWillClose: {
        print("options:onWillClose!")
    }, onWillOpen: {
        print("options:onWillOpen!")
    }, onDidClose: {
        print("options:onDidClose!")
    }, onDidOpen: {
        print("options:onDidOpen!")
    })
    
    var body: some View {
        NSideMenuView(options: options){
            Menu{
                MenuView(selectedView: $selectedView)
            }
            Main{
                switch selectedView {
                case "History":
                    SomeView(label: "History")
                case "Notifications":
                    SomeView(label: "Notifications")
                case "Settings":
                    SomeView(label: "Settings")
                case "About":
                    SomeView(label: "About")
                default:
                    HomeView()
                }
            }
        }
        .onAppear{
            options.width = 220
            options.onDidOpen = {
                print("options:onDidOpen!")
            }
            options.onDidClose = {
                print("options:onDidClose!")
            }
            options.onWillClose = {
                print("options:onWillClose!")
            }
            options.onWillOpen = {
                print("options:onWillOpen!")
            }
        }
        .environmentObject(options)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
