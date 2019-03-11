//
//  ModeratorsFetchResponse.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 11/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation
import ObjectMapper

class ModeratorsFetchResponse: Mappable {
    var page: Int?
    var pageSize: Int?
    var moderators: [Moderator]?
    var hasMore: Bool?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        page            <- map["page"]
        pageSize        <- map["page_size"]
        moderators      <- map["items"]
        hasMore         <- map["has_more"]
    }
}
