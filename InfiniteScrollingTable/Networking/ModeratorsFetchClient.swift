//
//  ModeratorsFetchClient.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 11/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ModeratorsFetchClient: NSObject {
    func fetch(page: Int,
               pageSize: Int,
               onSuccess: @escaping ((_ page: Int, _ pageSize: Int, _ hasMore: Bool, _ moderators: [Moderator]) -> Void),
               onFailure: @escaping ((ResponseError) -> Void)) {
        let scheme = "https"
        let host = "api.stackexchange.com"
        let path = "/2.2/users/moderators"
        let url = URL(string: "\(scheme)://\(host)\(path)")!
        
        var parameters = Parameters()
        parameters["page"] = page
        parameters["pagesize"] = pageSize
        parameters["order"] = "desc"
        parameters["sort"] = "reputation"
        parameters["site"] = "stackoverflow"
        parameters["filter"] = "!0Z-LvgkLYnfvSd0Ue5SnyMT.E"

        AF.request(url, method: .get, parameters: parameters).validate(statusCode: 200..<300).responseObject { (response: DataResponse<ModeratorsFetchResponse>) in
            // 'validate 200..<300'을 사용할 경우, ModeratorsFetchResponse를 파싱해 주지 않는다.
            // 따라서 response의 data를 직접 파싱해서 사용하여 메시지를 확인할 수 있다.
            
//            if let data = response.data {
//                log.info(String(data: data, encoding: .utf8))
//            }
            
            switch response.result {
            case let .success(response):
                onSuccess(response.page!, response.pageSize!, response.hasMore!, response.moderators!)
            case .failure:
//                if let data = response.data {
//                    log.info(String(data: data, encoding: .utf8))
//                }
                onFailure(ResponseError.network)
            }
        }
    }
}
