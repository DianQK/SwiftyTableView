//
//  SettingAvatarTableViewCell.swift
//  SwiftyTableView
//
//  Created by DianQK on 7/19/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit
import SnapKit

class SettingAvatarTableViewCell: UITableViewCell {
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var avatarImage: UIImage? {
        get {
            return avatarImageView.image
        }
        set {
            avatarImageView.image = newValue
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


private extension SettingAvatarTableViewCell {
    func configSubviews() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(self.contentView).offset(30)
            make.bottom.equalTo(self.contentView).offset(-30)
        }
        
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(20)
            make.trailing.equalTo(self.contentView).offset(-30)
            make.bottom.equalTo(self.contentView).offset(-20)
            make.width.equalTo(self.avatarImageView.snp.height)
        }
    }
}
