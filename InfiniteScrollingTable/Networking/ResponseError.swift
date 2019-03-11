//
//  ResponseError.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 11/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data "
        case .decoding:
            return "An error occurred while decoding data"
        }
    }
}
