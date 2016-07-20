//
//  Provider.swift
//  SwiftyTableView
//
//  Created by DianQK on 7/18/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit

public class Provider<S: SectionModelType>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    public typealias Item = S.ItemType
    public typealias Section = S.SectionType
    
    public typealias DataSourcesSectionModel = SectionModel<Section, Item>
    public typealias CellFactory = (Provider, UITableView, NSIndexPath, Item) -> UITableViewCell
    public typealias ModelSelect = (NSIndexPath, Item) -> ()
    public typealias ViewForHeaderInSection = ((Provider, Int, Section) -> UIView?)
    public typealias HeightForHeaderInSection = (Provider, Int, Section) -> CGFloat
    public typealias HeightForRowAtIndexPath = (Provider, NSIndexPath, Item) -> CGFloat
    
    public var sectionModels: [DataSourcesSectionModel] = [] {
        didSet {
            reload()
        }
    }
    
    private var tableViewType: UITableViewType!
    
    public var heightForRowAtIndexPath: HeightForRowAtIndexPath?
    
    public var configureCell: CellFactory!
    
    public var didSelect: ModelSelect?
    
    public var viewForHeaderInSection: ViewForHeaderInSection?
    public var heightForHeaderInSection: HeightForHeaderInSection?
    
    public var autoDeselectCell = true
    
    private var reload: (() -> ())!
    
    required convenience public init(_ tableViewType: UITableViewType) {
        self.init()
        tableViewType.dataSource = self
        tableViewType.delegate = self
        self.tableViewType = tableViewType
        reload = tableViewType.reloadData
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionModels.count
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionModels[section].items.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = sectionModels[indexPath.section].items[indexPath.item]
        return configureCell!(self, tableView, indexPath, item)
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightForRowAtIndexPath?(self, indexPath, sectionModels[indexPath.section].items[indexPath.item]) ?? tableViewType.rowHeight
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewForHeaderInSection?(self, section, sectionModels[section].section)
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSection?(self, section, sectionModels[section].section) ?? tableView.sectionHeaderHeight
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        didSelect?(indexPath, sectionModels[indexPath.section].items[indexPath.item])
        if autoDeselectCell {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

}