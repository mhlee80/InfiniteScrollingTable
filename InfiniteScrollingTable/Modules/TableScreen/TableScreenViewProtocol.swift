//
//  TableScreenViewProtocol.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 10/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation
import RxSwift

protocol TableScreenViewProtocol: class {
    var onViewDidLoad: PublishSubject<Void> { get }
    var onTableViewWillDisplayCell: PublishSubject<IndexPath> { get }
    
    var configureCell: ((_ cell: TableCellProtocol, _ at: IndexPath) -> Void)? { get set }
    
    var presenter: TableScreenPresenterProtocol? { get set }
    
    func reload()
}
