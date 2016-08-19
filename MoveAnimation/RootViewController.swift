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

public let ScreenWidth = UIScreen.main().bounds.size.width
public let ScreenHeight = UIScreen.main().bounds.size.height

class RootViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let f = UICollectionViewFlowLayout()
        f.minimumLineSpacing = 2
        f.minimumInteritemSpacing = 2
        f.scrollDirection = .vertical

        let c:UICollectionView = UICollectionView(frame:self.view.bounds, collectionViewLayout: f)
        c.backgroundColor = UIColor.white()
        c.delegate = self
        c.dataSource = self
        c.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        c.register(CollectionViewHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: headReuseIdentifier)
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white()
        self.view.addSubview(collectionView)
        
        CollectView.sharedManage.show(inView: self.view, action: {()->() in
            print("我被点击了")
            self.navigationController?.pushViewController(NextViewController(), animated: true)
        })
        
        print("file:\(#file),line:\(#line),column:\(#column),function:\(#function)")
        Util.instance1.test()
    }
}

extension RootViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.config("CollectionViewCell\((indexPath as NSIndexPath).item)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let head: CollectionViewHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headReuseIdentifier, for: indexPath) as! CollectionViewHeaderView
        head.config("Header:CollectionViewCell")
        return head
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: ScreenWidth, height: 44)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (ScreenWidth - 8) / 3, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 2, 0, 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        PopupAnimationView .show("收藏成功", inView: self.view, yOffset: 64, delay: 1) { 
            
        }
    }
}
