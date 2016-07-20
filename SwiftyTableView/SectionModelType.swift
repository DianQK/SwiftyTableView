//
//  SectionModelType.swift
//  SwiftyTableView
//
//  Created by DianQK on 7/18/16.
//  Copyright © 2016 T. All rights reserved.
//

import Foundation

public protocol SectionModelType {
    associatedtype ItemType
    associatedtype SectionType
    
    var section: SectionType { get }
    var items: [ItemType] { get }
    
    init(section: SectionType, items: [ItemType])
}
