//
//  TableCellProtocol.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 11/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation

protocol TableCellProtocol: class {
    static var CellIdentifier: String { get }
    
    var displayName: String? { get set }
    var reputation: Int { get set }
}
