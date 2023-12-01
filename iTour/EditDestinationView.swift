//
//  EditDestinationView.swift
//  iTour
//
//  Created by Stephen on 11/29/23.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    @Bindable var destination: Destination //cuz we gotta edit it too
    @State private var newSightName = ""
    
    var body: some View {
        Form { //Isn't this nice? that lil $ does a lot of work for you. Now you can edit that propery from your model.
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") { // new section cuz pickers don't have labels by default
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1) //disrespectful!
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented) //styling modifiers always go after the UI element's Curly Braces
            }
            
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    
                    Button("Add", action: addSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = "" //This clears the prompt for next use
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example Destination", details: "Example details go here and will automatically expand vertically as they are edited. This all wouldn't be necessary if preview weren't so dumb. Of course I'd need a preview of my app to simulate data storage and the like.")
        return EditDestinationView(destination:example)
            .modelContainer(container)
    } catch{
        fatalError("failed to create model container.")
    }
}
