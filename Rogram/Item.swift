//
//  Item.swift
//  Rogram
//
//  Created by Cory Santiago on 9/16/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
