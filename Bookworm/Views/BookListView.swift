//
//  BookListView.swift
//  Bookworm
//
//  Created by Chris Eadie on 15/07/2020.
//

import SwiftUI

struct BookListView: View {
  @Environment(\.managedObjectContext) var moc
  
  @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.rating, ascending: true), NSSortDescriptor(keyPath: \Book.title, ascending: true), NSSortDescriptor(keyPath: \Book.author, ascending: true)]) var books: FetchedResults<Book>
  
  @State private var showingAddBookView = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(books, id: \.self) { book in
          BookRow(for: book)
        }
        .onDelete { indexSet in
          deleteBooks(at: indexSet)
        }
      }
      .navigationBarTitle(Text("Bookworm"))
      .navigationBarItems(
        leading:
          EditButton()
        ,
        trailing:
          Button(
            action: {
              self.showingAddBookView.toggle()
            },
            label: {
              Image(systemName: "plus")
            }
          )
      )
      .sheet(isPresented: $showingAddBookView) {
        AddBookView().environment(\.managedObjectContext, self.moc)
      }
    }
  }
  
  struct BookRow: View {
    let book: Book
    let title: String?
    let rating: Int16
    let author: String?
    
    var body: some View {
      NavigationLink(
        destination: BookDetailView(book: book),
        label: {
          EmojiRatingView(rating: rating)
            .font(.largeTitle)
          VStack(alignment: .leading) {
            Text(title ?? "Unknown title")
              .font(.headline)
            Text(author ?? "Unknown author")
              .foregroundColor(.secondary)
          }
        }
      )
    }
    
    init(for book: Book) {
      self.book = book
      self.title = book.title
      self.rating = book.rating
      self.author = book.author
    }
  }
  
  func deleteBooks(at offsets: IndexSet) {
    for offset in offsets {
      let book = books[offset]
      
      moc.delete(book)
    }
    
    try? moc.save()
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BookListView()
  }
}
