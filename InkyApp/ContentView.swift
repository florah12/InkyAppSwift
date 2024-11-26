//
//  ContentView.swift
//  InkyApp
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house")
                    Text("HOME")
                }
            Search()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("SEARCH")
                }
            Write()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("WRITE")
                }
            Library()
                .tabItem {
                    Image(systemName: "book")
                    Text("LIBRARY")
                }
            Notifications()
                .tabItem {
                    Image (systemName: "bell")
                    Text("NOTIFICATIONS")
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
