//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Chris Eadie on 20/07/2020.
//

import SwiftUI
import CoreData

struct BookDetailView: View {
  @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
  @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
  
  let book: Book
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView {
        VStack {
          Text(self.book.title ?? "Unknown title")
            .font(.largeTitle)
            .fontWeight(.bold)
          Text("by \(self.book.author ?? "Unknown author")")
            .font(.title2)
          ZStack(alignment: .bottomTrailing) {
            Image(self.book.genre ?? "FANTASY")
            Text(self.book.genre?.uppercased() ?? "Unknown")
              .font(.caption)
              .fontWeight(.black)
              .padding(8)
              .foregroundColor(.white)
              .background(Color.black.opacity(0.75))
              .clipShape(Capsule())
              .offset(x: -5, y: -5)
          }
            .frame(maxWidth: geometry.size.width)
          RatingView(rating: .constant(Int(self.book.rating)))
            .font(.largeTitle)
            .padding()
          Text(self.book.review ?? "No review")
            .padding(.horizontal, 10)
          Spacer()
        }
      }
    }
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
