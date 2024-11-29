import SwiftUI

struct Write: View {
    @Binding var books: [Book]
    @State private var selectedBook: Book?
    @State private var newBookName: String = ""
    @State private var newBookCover: UIImage? = nil
    @State private var isCreatingNewBook = false
    @State private var showImagePicker = false
    @State private var textContent: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // Display books horizontally
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(books) { book in
                            Button(action: {
                                selectedBook = book
                                textContent = book.content ?? ""
                                isCreatingNewBook = false
                            }) {
                                VStack {
                                    if let cover = book.cover {
                                        Image(uiImage: cover)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 150)
                                            .cornerRadius(10)
                                            .clipped()
                                    } else {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 100, height: 150)
                                            .overlay(Text("No Cover").font(.caption))
                                    }
                                    Text(book.title)
                                        .font(.headline)
                                        .lineLimit(1)
                                }
                            }
                        }
                        Button(action: {
                            isCreatingNewBook = true
                            selectedBook = nil
                            textContent = ""
                        }) {
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.green)
                                    .frame(width: 100, height: 150)
                                    .overlay(Text("+ New Book").font(.headline).foregroundColor(.white))
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                Divider()

                if isCreatingNewBook {
                    VStack {
                        TextField("Enter book title", text: $newBookName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        Button(action: {
                            showImagePicker = true
                        }) {
                            HStack {
                                if let cover = newBookCover {
                                    Image(uiImage: cover)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                        .cornerRadius(10)
                                } else {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.blue.opacity(0.2))
                                        .frame(height: 100)
                                        .overlay(Text("Select Book Cover").foregroundColor(.blue))
                                }
                            }
                        }
                        .padding()

                        Button(action: {
                            guard !newBookName.isEmpty else { return }
                            let newBook = Book(title: newBookName, content: "", cover: newBookCover)
                            books.append(newBook)
                            saveBooks()
                            newBookName = ""
                            newBookCover = nil
                            isCreatingNewBook = false
                            textContent = ""
                        }) {
                            Text("Create")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                } else if let selectedBook = selectedBook {
                    VStack {
                        Text("Editing \(selectedBook.title)")
                            .font(.headline)
                            .padding()

                        TextEditor(text: $textContent)
                            .frame(height: 300)
                            .border(Color.gray, width: 1)
                            .padding()

                        Button(action: {
                            if let index = books.firstIndex(where: { $0.id == selectedBook.id }) {
                                books[index].content = textContent
                                saveBooks()
                            }
                        }) {
                            Text("Save")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                } else {
                    Text("Select or create a book to start writing.")
                        .font(.headline)
                        .padding()
                }

                Spacer()
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $newBookCover)
            }
            .onAppear {
                loadBooks()
            }
        }
    }

    func saveBooks() {
        do {
            let data = try JSONEncoder().encode(books)
            UserDefaults.standard.set(data, forKey: "books")
        } catch {
            print("Failed to save books: \(error.localizedDescription)")
        }
    }

    func loadBooks() {
        if let data = UserDefaults.standard.data(forKey: "books"),
           let decoded = try? JSONDecoder().decode([Book].self, from: data) {
            books = decoded
        }
    }
}

#Preview {
    Write(books: .constant([]))
}
