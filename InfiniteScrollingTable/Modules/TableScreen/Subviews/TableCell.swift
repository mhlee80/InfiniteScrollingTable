//
//  TableCell.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 11/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation
import UIKit

class TableCell: UITableViewCell {
    private struct Constant {
        struct Layout {
            static var DisplayNameLeftMargin: CGFloat = 16
            static var ReputationRightMargin: CGFloat = 16
        }
        
        struct Appearance {
            static var BackgroundColor: UIColor = .blue
            static var DisplayNameColor: UIColor = .black
            static var ReputationColor: UIColor = .black
        }
        
        struct Size {
            static var Indicator: CGSize = CGSize(width: 24, height: 24)
        }
    }
    
    private lazy var displayNameLabel: UILabel = {
        typealias A = Constant.Appearance
        
        let v = UILabel()
        v.textColor = A.DisplayNameColor
        v.textAlignment = .left
        return v
    }()
    
    private lazy var reputationLabel: UILabel = {
        typealias A = Constant.Appearance
        
        let v = UILabel()
        v.textColor = A.ReputationColor
        v.textAlignment = .right
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        typealias A = Constant.Appearance
        typealias L = Constant.Layout
        typealias S = Constant.Size
        
        backgroundColor = A.BackgroundColor
        
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(reputationLabel)
        
        displayNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(L.DisplayNameLeftMargin)
            make.centerY.equalToSuperview()
        }
        
        reputationLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-L.ReputationRightMargin)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableCell: TableCellProtocol {
    static var CellIdentifier: String { return String(describing: self) }
    
    var displayName: String? {
        get {
            return displayNameLabel.text
        }
        
        set(value) {
            displayNameLabel.text = value
        }
    }
    
    var reputation: Int {
        get {
            if let reputation = reputationLabel.text, let r = Int(reputation) {
                return r
            }
            
            return 0
        }
        
        set(value) {
            reputationLabel.text = String(value)
        }
    }
}
