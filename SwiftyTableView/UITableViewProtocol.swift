//
//  UITableViewProtocol.swift
//  SwiftyTableView
//
//  Created by DianQK on 7/18/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit

public protocol UITableViewType: class {
    weak var dataSource: UITableViewDataSource?{ get set }
    weak var delegate: UITableViewDelegate?{ get set }
    var rowHeight: CGFloat { get }
    func reloadData()
}

extension UITableView: UITableViewType {
    
}
