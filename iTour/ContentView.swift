//
//  ContentView.swift
//  iTour
//
//  Created by David Malicke on 11/12/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    /// Methods for when you know sort order at compile time
    //   @Query(sort: \Destination.priority, order: .reverse) var destinations: [Destination]
    //    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListView(sort: sortOrder)
                .navigationTitle("iTour")
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .toolbar {
                    Button("Add Samples", action: addSamples)
                    Button("Add Destination", systemImage: "plus" , action: addDestination)
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority, order: .reverse))
                            
                            Text("Date")
                                .tag(SortDescriptor(\Destination.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addSamples() {
        let rome = Destination(name: "Rome")
        let florence = Destination(name: "Florence")
        let naples = Destination(name: "Naples")
        
        modelContext.insert(rome)
        modelContext.insert(florence)
        modelContext.insert(naples)
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}
