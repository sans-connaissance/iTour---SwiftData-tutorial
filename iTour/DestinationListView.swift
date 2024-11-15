//
//  DestinationListView.swift
//  iTour
//
//  Created by David Malicke on 11/13/24.
//

import SwiftData
import SwiftUI

struct DestinationListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        
                        Text (destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestination)
        }
    }
    
    init(sort: SortDescriptor<Destination>, searchString: String) {
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
//    init(sort: SortDescriptor<Destination>) {
//        let now = Date.now
//        _destinations = Query(filter: #Predicate {
//            $0.date > now
//        }, sort: [sort])
//    }
    
//    init(sort: SortDescriptor<Destination>) {
//        _destinations = Query(sort: [sort])
//    }
    
    func deleteDestination(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListView(sort: SortDescriptor(\Destination.name), searchString: "")
}
