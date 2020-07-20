//
//  ContentView.swift
//  Bookworm
//
//  Created by Chris Eadie on 15/07/2020.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) var moc
  
  @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
  
  @State private var showingAddBookView = false
  
  var unknown = "Unknown "
  
  var body: some View {
    NavigationView {
      if books.count == 0 { Text("Count: \(books.count)") } else {
      List {
        ForEach(books, id: \.self) { book in
          BookRowFor(book)
        }
      }
      .navigationBarTitle(Text("Bookworm"))
      .navigationBarItems(
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
      }}
  }
  
  struct BookRowFor: View {
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
    
    init(_ book: Book) {
      self.book = book
      self.title = book.title
      self.rating = book.rating
      self.author = book.author
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
