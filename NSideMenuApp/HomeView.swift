//
//  HomeView.swift
//  NSideMenuApp
//
//  Created by Najim on 12/2/21.
//

import SwiftUI
import NSideMenu

struct HomeView: View {
    var body: some View {
        SomeView(label: "Home")
    }
}

struct SomeView: View {
    var label: String
    @EnvironmentObject var options: NSideMenuOptions
    var body: some View {
        NavigationView{
            VStack{
                Text(label)
                    .padding()
                Text("Menu Visible: "+options.show.description)
            }
            .frame(maxHeight: .infinity)
            .toolbar(content: {
                ToolbarItem(placement: options.side.getToolbarItemPlacement(), content: {
                    if(!options.show){
                        Button {
                            options.toggleMenu()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
                })
            }).id(UUID())
                .navigationTitle(label)
                .navigationBarTitleDisplayMode(.large)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
