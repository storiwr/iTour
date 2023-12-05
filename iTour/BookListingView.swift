//
//  BookListingView.swift
//  iTour
//
//  Created by Stephen on 11/29/23.
//

import SwiftData
import SwiftUI

struct BookListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Book.priority, order: .reverse), SortDescriptor(\Book.title)]) var books: [Book] //Macro to read all desitnation objects and display in array. Also watches for changes. The sort descriptor mess will hopefully be clearer later
    var body: some View {
        List {
            ForEach(books) { book in
                NavigationLink(value: book) { //now each item gets a link to edit view. Maybe better to be detail view with an edit button, but that's for later me.
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteBooks)
        }//We're shifting things between views and I don't know what's real anymore!
    }
    
    init(sort: SortDescriptor<Book>, searchString:String) { //we're beyond me now. Something hidden? Feels dangerous! Sort by is such a common thing that surely it'll be built in soon.
        
        
        _books = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.title.localizedStandardContains(searchString) //almost always best way to compare user-facing string checks. does all the fuzzy work
            }
        }, sort: [sort]) //This is the actual query itself
        
    }
    
    func deleteBooks(_ indexSet: IndexSet) {
        for index in indexSet {
            let book = books[index]
            modelContext.delete(book) //delete book see? pattern!
        }
    }
}

#Preview {
    BookListingView(sort: SortDescriptor(\Book.title), searchString: "") //Preview needs to be told since it doesn't have user choice saved I guess?
}
