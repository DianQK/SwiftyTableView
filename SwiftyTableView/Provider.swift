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
    public typealias CellFactory = (Provider, UITableView, IndexPath, Item) -> UITableViewCell
    public typealias ModelSelect = (IndexPath, Item) -> ()
    public typealias ViewForHeaderInSection = ((Provider, Int, Section) -> UIView?)
    public typealias HeightForHeaderInSection = (Provider, Int, Section) -> CGFloat
    public typealias HeightForRowAtIndexPath = (Provider, IndexPath, Item) -> CGFloat
    
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
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionModels.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionModels[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sectionModels[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).item]
        return configureCell!(self, tableView, indexPath, item)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAtIndexPath?(self, indexPath, sectionModels[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).item]) ?? tableViewType.rowHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewForHeaderInSection?(self, section, sectionModels[section].section)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSection?(self, section, sectionModels[section].section) ?? tableView.sectionHeaderHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath, sectionModels[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).item])
        if autoDeselectCell {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}
