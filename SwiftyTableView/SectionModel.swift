//
//  SectionModel.swift
//  SwiftyTableView
//
//  Created by DianQK on 7/18/16.
//  Copyright © 2016 T. All rights reserved.
//

import Foundation

public struct SectionModel<Section, Item>: SectionModelType {
    
    public var section: Section
    public var items: [Item]
    
    public init(section: Section, items: [Item]) {
        self.section = section
        self.items = items
    }

}
