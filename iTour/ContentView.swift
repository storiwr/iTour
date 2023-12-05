//
//  ContentView.swift
//  Bookwormie? Bookerly? Bookstacks? Bookieboo?
//
//  Created by Stephen on 11/5/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Book]() //we kidnapped @Query and moved it to its own view
    @State private var sortOrder = SortDescriptor(\Book.title) //Starting the 5 steps to user directed sort order
    @State private var searchText = "" //dynamic fitlering via search yay
    
    var body: some View {
        NavigationStack(path: $path) { //I think this is opening up the view to accept new data? It's necessary to allow creating new books. Shows it right now...
            BookListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("Books")
                .navigationDestination(for: Book.self, destination: EditBookView.init) //Hey you! Start showing edit book view for this item Is this destination not the one we created when this was iTour?
                .searchable(text:$searchText)
                .toolbar {
                    Button("Add Book", systemImage: "plus", action: addBook) //when you have () at the end is a bit confusing. Maybe cuz we don't need to pass arguments?
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Book.title))
                            Text("Priority")
                                .tag(SortDescriptor(\Book.priority, order:.reverse))
                            Text("Date")
                                .tag(SortDescriptor(\Book.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addBook() { //singular vs plural can make head hurt
        let book = Book()
        modelContext.insert(book) //add book
        path = [book] //show it now! Path is confusing
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
