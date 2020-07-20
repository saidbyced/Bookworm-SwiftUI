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
  
    var body: some View {
      NavigationView {
        Text("Count: \(books.count)")
          .navigationBarTitle(Text("Bookworm"))
          .navigationBarItems(trailing:
            Button(action: {
              self.showingAddBookView.toggle()
            }, label: {
              Image(systemName: "plus")
            })
          )
          .sheet(isPresented: $showingAddBookView) {
            AddBookView().environment(\.managedObjectContext, self.moc)
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
