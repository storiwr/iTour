//
//  DestinationListingView.swift
//  iTour
//
//  Created by Stephen on 11/29/23.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination] //Macro to read all desitnation objects and display in array. Also watches for changes. The sort descriptor mess will hopefully be clearer later
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) { //now each item gets a link to edit view. Maybe better to be detail view with an edit button, but that's for later me.
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }//We're shifting things between views and I don't know what's real anymore!
    }
    
    init(sort: SortDescriptor<Destination>, searchString:String) { //we're beyond me now. Something hidden? Feels dangerous! Sort by is such a common thing that surely it'll be built in soon.
        
        
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString) //almost always best way to compare user-facing string checks. does all the fuzzy work
            }
        }, sort: [sort]) //This is the actual query itself
        
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination) //delete destination see? pattern!
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "") //Preview needs to be told since it doesn't have user choice saved I guess? 
}
