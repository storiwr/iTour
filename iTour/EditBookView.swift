//
//  EditBookView.swift
//  iTour
//
//  Created by Stephen on 11/29/23.
//TODO: Add save button

import SwiftUI
import SwiftData

struct EditBookView: View {
    @Bindable var book: Book //cuz we gotta edit it too
    @State private var newSightName = ""
    
    var body: some View {
        Form { //Isn't this nice? that lil $ does a lot of work for you. Now you can edit that propery from your model.
            TextField("Name", text: $book.title)
            TextField("Details", text: $book.details, axis: .vertical)
            DatePicker("Date", selection: $book.date)
            
            Section("Priority") { // new section cuz pickers don't have labels by default
                Picker("Priority", selection: $book.priority) {
                    Text("Meh").tag(1) //disrespectful!
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented) //styling modifiers always go after the UI element's Curly Braces
            }
            
            Section("Sights") {
                ForEach(book.sights) { sight in
                    Text(sight.name)
                }
                
                HStack {
                    TextField("Add a new sight in \(book.title)", text: $newSightName)
                    
                    Button("Add", action: addSight)
                }
            }
        }
        .navigationTitle("Edit Book")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            book.sights.append(sight)
            newSightName = "" //This clears the prompt for next use
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(name: "Example Book", details: "Example details go here and will automatically expand vertically as they are edited. This all wouldn't be necessary if preview weren't so dumb. Of course I'd need a preview of my app to simulate data storage and the like.")
        return EditBookView(book:example)
            .modelContainer(container)
    } catch{
        fatalError("failed to create model container.")
    }
}
