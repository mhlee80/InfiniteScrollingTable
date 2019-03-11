//
//  TableScreenWireframe.swift
//  InfiniteScrollingTable
//
//  Created by mhlee on 10/03/2019.
//  Copyright © 2019 mhlee. All rights reserved.
//

import Foundation
import UIKit

class TableScreenWireframe: NSObject, TableScreenWireframeProtocol {
    class func createModule() -> UIViewController {
        let view = TableScreenView()
        let presenter = TableScreenPresenter()
        let interactor = TableScreenInteractor()
        let wireframe = TableScreenWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        return view
    }
}
