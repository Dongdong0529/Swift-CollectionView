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
        label.textColor = UIColor.gray()
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(titleLabel)
        self.backgroundColor = UIColor.lightGray()
    }
    
    func config(_ title: String?) {
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width: CGFloat = bounds.width
        let height: CGFloat = bounds.height
        titleLabel.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
}
