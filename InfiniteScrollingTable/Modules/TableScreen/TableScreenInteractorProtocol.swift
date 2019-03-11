//
//  TableScreenInteractorProtocol.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 10/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation

protocol TableScreenInteractorProtocol: class {
    func fetchModerators(page: Int,
                         pageSize: Int,
                         onSuccess: @escaping ((_ page: Int, _ pageSize: Int, _ hasMore: Bool, _ moderators: [Moderator]) -> Void),
                         onFailure: @escaping ((ResponseError) -> Void))
}
