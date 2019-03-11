//
//  TableScreenPresenter.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 10/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation
import RxSwift

class TableScreenPresenter: NSObject, TableScreenPresenterProtocol {
    private var disposeBag = DisposeBag()
    
    weak var view: TableScreenViewProtocol? {
        didSet {
            resetBindings()
        }
    }
    
    var interactor: TableScreenInteractorProtocol? {
        didSet {
            resetBindings()
        }
    }
    
    var wireframe: TableScreenWireframeProtocol? {
        didSet {
            resetBindings()
        }
    }
    
    private var page = 0
    private var nextPage: Int { return page + 1}
    private var pageSize = 30
    private var hasMore: Bool?
    private var isFetchInProgress: Bool = false
    
    var moderators = [Moderator]()
    var moderatorsCount: Int { return moderators.count }
    
    private let prefetchThreshold = 5
    
    private func resetBindings() {
        disposeBag = DisposeBag()
        
        if let v = view {
            v.onViewDidLoad.subscribe(onNext: { [weak self] Void in
                self?.onViewDidLoad()
            }).disposed(by: disposeBag)
            
            v.onTableViewWillDisplayCell.subscribe(onNext: { [weak self] indexPath in
                self?.onTableViewWillDisplayCell(at: indexPath)
            }).disposed(by: disposeBag)
            
            v.configureCell = { [weak self] cell, indexPath in
                self?.configureCell(cell, at: indexPath)
            }
        }
    }
    
    private func onViewDidLoad() {
        fetchModerators()
    }
    
    private func onTableViewWillDisplayCell(at indexPath: IndexPath) {
        if needToFetchNextPageWhenDisplayingCell(at: indexPath) {
            fetchModerators()
        }
    }
    
    private func needToFetchNextPageWhenDisplayingCell(at indexPath: IndexPath) -> Bool {
        return indexPath.row > moderatorsCount - prefetchThreshold
    }
    
    private func configureCell(_ cell: TableCellProtocol, at indexPath: IndexPath) {
        let moderator = moderators[indexPath.row]
        cell.displayName = moderator.displayName
        cell.reputation = moderator.reputation
    }
    
    func fetchModerators() {
        if let hasMore = hasMore, !hasMore { return }
        if isFetchInProgress { return }
        
        isFetchInProgress = true
        
        interactor?.fetchModerators(
            page: nextPage,
            pageSize: pageSize,
            onSuccess: { [weak self] page, pageSize, hasMore, moderators in
                DispatchQueue.main.async {
                    self?.page = page
                    self?.hasMore = hasMore
                    self?.moderators.append(contentsOf: moderators)
                    self?.isFetchInProgress = false
                    self?.view?.reload()
                }
        },
            onFailure: { [weak self] error in
                log.info(error.reason)
                self?.isFetchInProgress = false
        })
    }
}
