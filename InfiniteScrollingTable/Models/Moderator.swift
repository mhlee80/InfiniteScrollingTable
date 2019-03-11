//
//  Moderator.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 11/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation
import ObjectMapper

class Moderator: Mappable {
    var displayName: String = ""
    var reputation: Int = 0
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        displayName     <- map["display_name"]
        reputation      <- map["reputation"]
    }
}
