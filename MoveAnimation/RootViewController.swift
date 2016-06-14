//
//  RootViewController.swift
//  MoveAnimation
//
//  Created by Dongdong on 16/6/2.
//  Copyright © 2016年 com. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "CollectionViewCell"
private let headReuseIdentifier = "CollectionViewHeaderView"

public let ScreenWidth = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight = UIScreen.mainScreen().bounds.size.height

class RootViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let f = UICollectionViewFlowLayout()
        f.minimumLineSpacing = 2
        f.minimumInteritemSpacing = 2
        f.scrollDirection = .Vertical
        
        let c:UICollectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: f)
        c.backgroundColor = UIColor.whiteColor()
        c.delegate = self
        c.dataSource = self
        c.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        c.registerClass(CollectionViewHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: headReuseIdentifier)
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
        
        CollectView.sharedManage.show(inView: self.view, action: {()->() in
            print("我被点击了")
            self.navigationController?.pushViewController(NextViewController(), animated: true)
        })
    }
}

extension RootViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.config("CollectionViewCell\(indexPath.item)")
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let head: CollectionViewHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headReuseIdentifier, forIndexPath: indexPath) as! CollectionViewHeaderView
        head.config("Header:CollectionViewCell")
        return head
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(ScreenWidth, 44)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((ScreenWidth - 8) / 3, 44)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 2, 0, 2)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        PopupAnimationView .show("收藏成功", inView: self.view, yOffset: 64, delay: 1) { 
            
        }
    }
}
