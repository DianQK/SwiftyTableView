//
//  UITableViewExtension.swift
//  SwiftyTableView
//
//  Created by DianQK on 7/19/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit

public protocol IdentifiableType {
    associatedtype Identifier: Hashable
    
    static var identifier : Identifier { get }
}

extension UITableViewCell: IdentifiableType {
    public static var identifier: String {
        return "\(self)"
    }
}

public extension UITableView {
    public func st_dequeueReusableCell<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierable identifierable: Cell.Type, for indexPath: NSIndexPath) -> Cell {
        return dequeueReusableCellWithIdentifier(identifierable.identifier, forIndexPath: indexPath) as! Cell
    }
    
    public func st_dequeueReusableCell<Cell: UITableViewCell where Cell: IdentifiableType>(for indexPath: NSIndexPath) -> (Cell.Type) -> Cell {
        return { [unowned self] type in
            return self.dequeueReusableCellWithIdentifier(type.identifier, forIndexPath: indexPath) as! Cell
        }
    }
    
    public func st_registerReuseCell<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierable identifierable: Cell.Type) {
        registerClass(identifierable, forCellReuseIdentifier: identifierable.identifier)
    }
    
    public func st_registerReuseCells<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierables identifierables: [Cell.Type]) {
        for identifierable in identifierables {
            st_registerReuseCell(withIdentifierable: identifierable)
        }
    }
    
    //    func st_registerReuseCells<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierables identifierables: Cell.Type...) {
    //        for identifierable in identifierables {
    //            st_registerReuseCell(withIdentifierable: identifierable)
    //        }
    //    }
}