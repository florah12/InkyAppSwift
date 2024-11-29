import SwiftUI

struct Search: View {
    @Binding var books: [Book] // List of all books
    @State private var searchTerm = ""
    @State private var filteredBooks: [Book] = [] // Filtered results

    var body: some View {
        NavigationView {
            VStack {
                if !filteredBooks.isEmpty {
                    List(filteredBooks) { book in
                        NavigationLink(destination: ReaderView(book: book, recentlyViewedBooks: .constant([]))) {
                            HStack {
                                if let cover = book.cover {
                                    Image(uiImage: cover)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                } else {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 50, height: 50)
                                        .overlay(Text("No Cover").font(.caption))
                                }

                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.headline)

                                    Text(book.content ?? "No content")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                            }
                        }
                    }
                } else {
                    if searchTerm.isEmpty {
                        Text("Start typing to search for books, authors, or tags.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        Text("No results found.")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchTerm, prompt: "Search stories, authors, or tags")
            .onChange(of: searchTerm) { newValue in
                filterBooks()
            }
        }
    }

    private func filterBooks() {
        if searchTerm.isEmpty {
            filteredBooks = []
        } else {
            filteredBooks = books.filter {
                $0.title.lowercased().contains(searchTerm.lowercased()) ||
                ($0.content?.lowercased().contains(searchTerm.lowercased()) ?? false)
            }
        }
    }
}

#Preview {
    Search(books: .constant([
        Book(title: "Sample Book 1", content: "A wonderful story about life.", cover: nil),
        Book(title: "Adventure Tales", content: "Explore the wild adventures.", cover: nil),
        Book(title: "Cooking Made Easy", content: "Learn to cook delicious meals.",  cover: nil)
    ]))
}
