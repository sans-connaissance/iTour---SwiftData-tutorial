//
//  Site.swift
//  iTour
//
//  Created by David Malicke on 11/14/24.
//

import Foundation
import SwiftData

@Model
class Site {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
