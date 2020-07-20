//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Chris Eadie on 20/07/2020.
//

import SwiftUI
import CoreData

struct BookDetailView: View {
  let book: Book
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView {
        VStack {
          ZStack(alignment: .bottomTrailing) {
            Image(self.book.genre ?? "FANTASY")
            Text(self.book.genre?.uppercased() ?? "FANTASY")
              .font(.caption)
              .fontWeight(.black)
              .padding(8)
              .foregroundColor(.white)
              .background(Color.black.opacity(0.75))
              .clipShape(Capsule())
              .offset(x: -5, y: -5)
          }
            .frame(maxWidth: geometry.size.width)
          Text(self.book.author ?? "Unknown author")
            .font(.title)
          RatingView(rating: .constant(Int(self.book.rating)))
            .font(.largeTitle)
          Text(self.book.review ?? "No review")
            .padding()
          Spacer()
        }
      }
    }
    .navigationBarTitle(Text(book.title ?? "Unknown book")/*, displayMode: .inline*/)
  }
}

struct BookDetailView_Previews: PreviewProvider {
  static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  
  static var previews: some View {
    let book = Book(context: moc)
    book.title = "Test Book"
    book.author = "Test Author"
    book.genre = "Fantasy"
    book.rating = 4
    book.review = "This was a great book; I really enjoyed it."
    
    return NavigationView {
      BookDetailView(book: book)
    }
  }
}
