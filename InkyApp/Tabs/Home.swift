import SwiftUI

struct Home: View {
    @Binding var recentlyViewedBooks: [Book]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                RecommendationsSection()
                RecentlyViewedSection(recentlyViewedBooks: recentlyViewedBooks)
            }
            .padding(.top)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: UserProfile()) {
                    Image(systemName: "person.crop.circle")
                        .font(.title)
                }
            }
        }
    }
}

struct RecommendationsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recommendations")
                .font(.title2)
                .bold()
                .padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<10) { index in
                        BookCard(book: Book(
                            title: "Recommended Book \(index + 1)",
                            content: "Author \(index + 1)",
                            cover: nil
                        ))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RecentlyViewedSection: View {
    let recentlyViewedBooks: [Book]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recently Viewed")
                .font(.title2)
                .bold()
                .padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(recentlyViewedBooks) { book in
                        BookCard(book: book)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
