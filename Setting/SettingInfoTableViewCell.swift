//
//  SettingInfoTableViewCell.swift
//  SwiftyTableView
//
//  Created by DianQK on 7/19/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit

class SettingInfoTableViewCell: UITableViewCell {
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var detailInfo: String? {
        get {
            return detailInfoLabel.text
        }
        set {
            detailInfoLabel.text = newValue
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var detailInfoLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension SettingInfoTableViewCell {
    func configSubviews() {
        contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(15)
            make.leading.equalTo(self.contentView).offset(30)
            make.bottom.equalTo(self.contentView).offset(-15)
        }
        
        contentView.addSubview(detailInfoLabel)
        detailInfoLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(15)
            make.trailing.equalTo(self.contentView).offset(-30)
            make.bottom.equalTo(self.contentView).offset(-15)
        }
    }
}
