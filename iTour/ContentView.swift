//
//  ContentView.swift
//  iTour
//
//  Created by Stephen on 11/5/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Destination]() //we kidnapped @Query and moved it to its own view
    @State private var sortOrder = SortDescriptor(\Destination.name) //Starting the 5 steps to user directed sort order
    @State private var searchText = "" //dynamic fitlering via search yay
    
    var body: some View {
        NavigationStack(path: $path) { //I think this is opening up the view to accept new data? It's necessary to allow creating new destinations. Shows it right now...
            DestinationListingView(sort: sortOrder, searchString: searchText) 
                .navigationTitle("iTour")
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init) //Hey you! Start showing edit destination view for this item
                .searchable(text:$searchText)
                .toolbar {
                    Button("Add Destination", systemImage: "plus", action: addDestination) //when you have () at the end is a bit confusing. Maybe cuz we don't need to pass arguments?
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority, order:.reverse))
                            Text("Date")
                                .tag(SortDescriptor(\Destination.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addDestination() { //singular vs plural can make head hurt
        let destination = Destination()
        modelContext.insert(destination) //add destination
        path = [destination] //show it now! Path is confusing
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
