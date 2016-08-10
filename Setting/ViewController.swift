//
//  ViewController.swift
//  Setting
//
//  Created by DianQK on 7/19/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit
import SwiftyTableView

private typealias SettingSectionModel = SectionModel<String, Style>

private enum Style {
    case text(title: String, detail: String)
    case image(title: String, image: UIImage)
}

class ViewController: UIViewController {
    
    private lazy var settingTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private lazy var provider: Provider<SettingSectionModel> = {
        let provider = Provider<SettingSectionModel>(self.settingTableView)
        return provider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 添加视图

        view.addSubview(settingTableView)
        settingTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        // MARK: - 注册 TableView Cell
        
        settingTableView.st.registerReuseCells(
            withIdentifierables: [
                SettingAvatarTableViewCell.self,
                SettingInfoTableViewCell.self]
        )
        
        // MARK: 配置 TableView Cell
        
        provider.configureCell = { provider, tableView, indexPath, value in
            switch value {
            case let .image(title, image):
                let cell = tableView.st.dequeueReusableCell(withIdentifierable: SettingAvatarTableViewCell.self, for: indexPath)
                cell.title = title
                cell.avatarImage = image
                return cell
            case let .text(title, detail):
                let cell = tableView.st.dequeueReusableCell(withIdentifierable: SettingInfoTableViewCell.self, for: indexPath)
                cell.title = title
                cell.detailInfo = detail
                return cell
            }
        }
        provider.heightForRowAtIndexPath = { provider, indexPath, value in
            switch value {
            case .image:
                return 120
            case .text:
                return 44
            }
        }
        
        // MARK: 配置 TableView Header

        provider.viewForHeaderInSection = { provider, section, value in
            let headerView = UIView()
            let titleLabel = UILabel()
            headerView.addSubview(titleLabel)
            titleLabel.text = value
            titleLabel.snp.makeConstraints { (make) in
                make.leading.equalTo(headerView).offset(20)
                make.bottom.equalTo(headerView).offset(-10)
            }
            return headerView
        }
        provider.heightForHeaderInSection = header(height: 60)
        
        // MARK: - 逻辑处理
        
        let profileSection = SettingSectionModel(
            section: "个人资料",
            items: [
                Style.image(title: "头像", image: UIImage(named: "avatar")!),
                Style.text(title: "邮箱", detail: "dianqk@icloud.com"),
                Style.text(title: "昵称", detail: "靛青K"),
                Style.text(title: "称谓", detail: "宋先生"),
                Style.text(title: "地址管理", detail: "未设置")
            ])
        let securitySection = SettingSectionModel(
            section: "账号安全",
            items: [
                Style.text(title: "手机号", detail: "152****0195"),
                Style.text(title: "密码", detail: "•••••")
            ])
        let otherSection = SettingSectionModel(
            section: "其他登录方式",
            items: [
                Style.text(title: "新浪微博", detail: "已启用"),
                Style.text(title: "微信", detail: "已启用")
            ])
        let sections = [profileSection, securitySection, otherSection]
        provider.sectionModels = sections
        
    }
    
    
}

