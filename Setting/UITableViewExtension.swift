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

public struct Swifty<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

extension NSObjectProtocol {
    var st: Swifty<Self> {
        return Swifty(self)
    }
}

extension Swifty where Base: UITableView {
    public func dequeueReusableCell<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierable identifierable: Cell.Type, for indexPath: NSIndexPath) -> Cell {
        return base.dequeueReusableCellWithIdentifier(identifierable.identifier, forIndexPath: indexPath) as! Cell
    }
    
    public func dequeueReusableCell<Cell: UITableViewCell where Cell: IdentifiableType>(for indexPath: NSIndexPath) -> (Cell.Type) -> Cell {
        return { [unowned base] type in
            return base.dequeueReusableCellWithIdentifier(type.identifier, forIndexPath: indexPath) as! Cell
        }
    }
    
    public func registerReuseCell<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierable identifierable: Cell.Type) {
        base.registerClass(identifierable, forCellReuseIdentifier: identifierable.identifier)
    }
    
    public func registerReuseCells<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierables identifierables: [Cell.Type]) {
        for identifierable in identifierables {
            registerReuseCell(withIdentifierable: identifierable)
        }
    }
}
