import SwiftUI

struct Bookshelf: View {
    @Binding var books: [Book]
    @Binding var recentlyViewedBooks: [Book]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Bookshelf")
                        .font(.largeTitle.bold())
                        .padding(.horizontal)
                        .padding(.top, 20)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(books) { book in
                            ZStack(alignment: .topTrailing) {
                                NavigationLink(destination: ReaderView(book: book, recentlyViewedBooks: $recentlyViewedBooks)) {
                                    BookGridCard(book: book)
                                }

                                // Delete Button
                                Button(action: {
                                    deleteBook(book)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                }
                                .offset(x: -10, y: 10)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
        }
    }

    private func deleteBook(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books.remove(at: index)
            saveBooks()
        }
    }

    private func saveBooks() {
        do {
            let data = try JSONEncoder().encode(books)
            UserDefaults.standard.set(data, forKey: "books")
        } catch {
            print("Failed to save books: \(error.localizedDescription)")
        }
    }
}

struct BookGridCard: View {
    let book: Book

    var body: some View {
        VStack(alignment: .leading) {
            if let cover = book.cover {
                Image(uiImage: cover)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipped()
                    .cornerRadius(15)
            } else {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 150, height: 150)
                    .overlay(Text("No Cover").font(.caption))
            }

            Text(book.title)
                .font(.headline)
                .lineLimit(1)
                .padding(.top, 5)

            Text(book.content ?? "No content")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
    }
}

#Preview {
    Bookshelf(books: .constant([
        Book(title: "Book 1", content: "Some content.", cover: nil),
        Book(title: "Book 2", content: "More content.", cover: nil)
    ]), recentlyViewedBooks: .constant([]))
}
