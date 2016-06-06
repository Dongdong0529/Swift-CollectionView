//
//  CollectionViewHeaderView.swift
//  MoveAnimation
//
//  Created by Dongdong on 16/6/6.
//  Copyright © 2016年 com. All rights reserved.
//

import UIKit

class CollectionViewHeaderView: UICollectionReusableView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.grayColor()
        label.font = UIFont.systemFontOfSize(14)
        label.textAlignment = .Left
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.backgroundColor = UIColor.yellowColor()
    }
    
    func config(title: String?) {
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let x: CGFloat = 15
        let y: CGFloat = (CGRectGetHeight(bounds) - 14) / 2
        let width: CGFloat = 200
        let height: CGFloat = 14
        titleLabel.frame = CGRectMake(x, y, width, height)
    }
}
