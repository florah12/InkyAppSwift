import SwiftUI

struct ContentView: View {
    @State private var books: [Book] = [] // Shared book list between tabs
    @State private var recentlyViewedBooks: [Book] = [] // Recently viewed books

    var body: some View {
        NavigationView {
            TabView {
                // Home Tab
                Home(recentlyViewedBooks: $recentlyViewedBooks)
                    .tabItem {
                        Image(systemName: "house")
                        Text("HOME")
                    }

                // Search Tab
                Search(books: $books) // Pass books to Search view
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("SEARCH")
                    }

                // Write Tab
                Write(books: $books)
                    .tabItem {
                        Image(systemName: "pencil")
                        Text("WRITE")
                    }

                // Bookshelf Tab
                Bookshelf(books: $books, recentlyViewedBooks: $recentlyViewedBooks)
                    .tabItem {
                        Image(systemName: "book")
                        Text("BOOKSHELF")
                    }

                // Notifications Tab (Placeholder)
                Notifications()
                    .tabItem {
                        Image(systemName: "bell")
                        Text("NOTIFICATIONS")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
