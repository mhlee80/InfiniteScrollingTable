//
//  TableScreenInteractor.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 10/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation

class TableScreenInteractor: NSObject, TableScreenInteractorProtocol {
    private var client = ModeratorsFetchClient()
    
    func fetchModerators(page: Int,
                         pageSize: Int,
                         onSuccess: @escaping ((_ page: Int, _ pageSize: Int, _ hasMore: Bool, _ moderators: [Moderator]) -> Void),
                         onFailure: @escaping ((ResponseError) -> Void)) {
        client.fetch(page: page, pageSize: pageSize, onSuccess: onSuccess, onFailure: onFailure)
    }
}
