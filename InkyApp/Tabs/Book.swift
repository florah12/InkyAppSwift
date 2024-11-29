import SwiftUI

import UIKit

struct Book: Identifiable, Codable {
    let id: UUID
    let title: String
    var content: String? // Changed from let to var
    var cover: UIImage?

    init(title: String, content: String?, cover: UIImage?) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.cover = cover
    }

    // For encoding and decoding UIImage in UserDefaults
    private enum CodingKeys: String, CodingKey {
        case id, title, content, cover
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        content = try container.decode(String?.self, forKey: .content)

        if let imageData = try container.decodeIfPresent(Data.self, forKey: .cover) {
            cover = UIImage(data: imageData)
        } else {
            cover = nil
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)

        if let imageData = cover?.jpegData(compressionQuality: 0.8) {
            try container.encode(imageData, forKey: .cover)
        }
    }
}


struct BookCard: View {
    let book: Book

    var body: some View {
        VStack(alignment: .leading) {
            if let cover = book.cover {
                Image(uiImage: cover)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 180)
                    .clipped()
                    .cornerRadius(10)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 120, height: 180)
                    .overlay(
                        Text("Book Cover")
                            .font(.caption)
                            .foregroundColor(.gray)
                    )
            }

            Text(book.title)
                .font(.headline)
                .lineLimit(1)

            Text(book.content ?? "No content available")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .frame(width: 120)
    }
}

#Preview {
    BookCard(
        book: Book(
            title: "Sample Book",
            content: "Sample Content",
            cover: UIImage(named: "exampleImage")
        )
    )
}
