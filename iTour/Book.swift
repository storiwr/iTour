//
//  Book.swift
//  iTour
// A class used to define data model for each destination a user adds. Uses class because it lets it pass data around app.
//  Created by Stephen on 11/28/23.
//

import Foundation
import SwiftData //3 steps 1. import Swift data here and app.swift 2. add model macro to Destination.swift @Model  3. add view modifier to window group.

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    @Relationship(deleteRule: .cascade) var sights = [Sight]() //Makes it so when you delete Parent(destination) deletes children(sights) too! Way simpler than expected.
    
    // providing default values when makes sense ex: date being now be default
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
