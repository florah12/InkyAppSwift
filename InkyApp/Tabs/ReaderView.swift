import SwiftUI

struct ReaderView: View {
    let book: Book
    @Binding var recentlyViewedBooks: [Book]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let cover = book.cover {
                    Image(uiImage: cover)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .cornerRadius(12)
                }

                Text(book.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)

                Text(book.content ?? "No content available.")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding()
            }
            .onAppear {
                addToRecentlyViewed(book)
            }
            .navigationTitle("Reader")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func addToRecentlyViewed(_ book: Book) {
        if !recentlyViewedBooks.contains(where: { $0.id == book.id }) {
            recentlyViewedBooks.insert(book, at: 0)
            if recentlyViewedBooks.count > 10 {
                recentlyViewedBooks.removeLast()
            }
        }
    }
}

