//
//  SearchPage.swift
//  InkyApp


import SwiftUI

struct Search: View {
    @State private var searchTerm = ""
    var body: some View {
        NavigationStack{
            
        }
        .navigationTitle("Search")
        .searchable(text: $searchTerm, prompt: "Search stories, authors, or tags")
    }
}

#Preview {
    Search()
}
