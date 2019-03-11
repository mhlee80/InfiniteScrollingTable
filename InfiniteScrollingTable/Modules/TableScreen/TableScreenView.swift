//
//  TableScreenView.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 10/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class TableScreenView: UIViewController, TableScreenViewProtocol {
    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.register(TableCell.self, forCellReuseIdentifier: TableCell.CellIdentifier)
        v.backgroundColor = .white
        return v
    }()
    
    private let disposeBag = DisposeBag()
    
    let onViewDidLoad = PublishSubject<Void>()
    let onTableViewWillDisplayCell = PublishSubject<IndexPath>()
    
    var configureCell: ((_ cell: TableCellProtocol, _ at: IndexPath) -> Void)?
    
    var presenter: TableScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(view.safeAreaLayoutGuide)
        }

        tableView.dataSource = self
        tableView.delegate = self
//        tableView.prefetchDataSource = self
        
        onViewDidLoad.onNext(())
    }
    
    func reload() {
        tableView.reloadData()
    }
}

extension TableScreenView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.moderators.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.CellIdentifier, for: indexPath) as! TableCell
        configureCell?(cell, indexPath)
        return cell
    }
}

extension TableScreenView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        onTableViewWillDisplayCell.onNext(indexPath)
    }
}

//extension TableScreenView: UITableViewDataSourcePrefetching {
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        presenter?.prefetchModeratorsAtIndexPaths(indexPaths)
//    }
//}
