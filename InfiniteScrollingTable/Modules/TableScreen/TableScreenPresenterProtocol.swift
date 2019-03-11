//
//  TableScreenPresenterProtocol.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 10/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation

protocol TableScreenPresenterProtocol: class {
    var view: TableScreenViewProtocol? { get set }
    var interactor: TableScreenInteractorProtocol? { get set }
    var wireframe: TableScreenWireframeProtocol? { get set }
    
    var moderators: [Moderator] { get }
    var moderatorsCount: Int { get }
}
