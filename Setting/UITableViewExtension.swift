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
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public extension NSObjectProtocol {
    public var st: Swifty<Self> {
        return Swifty(self)
    }
}

extension Swifty where Base: UITableView {
    public func dequeueReusableCell<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierable identifierable: Cell.Type, for indexPath: IndexPath) -> Cell {
        return base.dequeueReusableCell(withIdentifier: identifierable.identifier, for: indexPath) as! Cell
    }
    
    public func dequeueReusableCell<Cell: UITableViewCell where Cell: IdentifiableType>(for indexPath: IndexPath) -> (Cell.Type) -> Cell {
        return { [unowned base] type in
            return base.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! Cell
        }
    }
    
    public func registerReuseCell<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierable identifierable: Cell.Type) {
        base.register(identifierable, forCellReuseIdentifier: identifierable.identifier)
    }
    
    public func registerReuseCells<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierables identifierables: [Cell.Type]) {
        for identifierable in identifierables {
            registerReuseCell(withIdentifierable: identifierable)
        }
    }
}

/*
public protocol UITableViewType: class {
    var tableView: UITableView { get }
}

extension UITableView: UITableViewType {
    public var tableView: UITableView {
        return self
    }
}

extension Swifty where Base: UITableViewType {
    public func dequeueReusableCell<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierable identifierable: Cell.Type, for indexPath: IndexPath) -> Cell {
        return base.tableView.dequeueReusableCell(withIdentifier: identifierable.identifier, for: indexPath) as! Cell
    }
    
    public func dequeueReusableCell<Cell: UITableViewCell where Cell: IdentifiableType>(for indexPath: IndexPath) -> (Cell.Type) -> Cell {
        return { [unowned base] type in
            return base.tableView.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! Cell
        }
    }
    
    public func registerReuseCell<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierable identifierable: Cell.Type) {
        base.tableView.register(identifierable, forCellReuseIdentifier: identifierable.identifier)
    }
    
    public func registerReuseCells<Cell: UITableViewCell where Cell: IdentifiableType>(withIdentifierables identifierables: [Cell.Type]) {
        for identifierable in identifierables {
            registerReuseCell(withIdentifierable: identifierable)
        }
    }
}
*/
