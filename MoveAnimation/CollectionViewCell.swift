//
//  CollectionViewCell.swift
//  MoveAnimation
//
//  Created by Dongdong on 16/6/6.
//  Copyright © 2016年 com. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.grayColor()
        label.font = UIFont.systemFontOfSize(14)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .Center
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(titleLabel)
        self.backgroundColor = UIColor.lightGrayColor()
    }
    
    func config(title: String?) {
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width: CGFloat = CGRectGetWidth(bounds)
        let height: CGFloat = CGRectGetHeight(bounds)
        titleLabel.frame = CGRectMake(0, 0, width, height)
    }
}
