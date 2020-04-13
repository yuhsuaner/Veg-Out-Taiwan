//
//  RestaurantCollectionViewFlowLayout.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/4/13.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

class RestaurantCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override open func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        
        let inset = (collectionView!.frame.size.width - itemSize.width) * 0.5
        sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 10, right: inset)
        
    }
    
    override open var collectionViewContentSize: CGSize {
        
        if collectionView == nil { return CGSize.zero }
        
        let itemsCount = CGFloat(collectionView!.numberOfItems(inSection: 0))
        
        return CGSize(width: itemSize.width * itemsCount + (itemSize.width * 1.2) / 414 * collectionView!.bounds.width ,
                      height: collectionView!.bounds.height)
        
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if collectionView == nil { return nil }
        
        // 從supser 獲取已經計算好的佈局屬性
        let attributes = super.layoutAttributesForElements(in: rect)
        
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2.0
        
        for attribute in attributes! {
            
            // cell 中心點 和 collectionView 中心點的間距
            let delta = Swift.abs(attribute.center.x - centerX)
            
            // 根據間隔距離計算縮放比例
            let scale = 1.2 - delta / collectionView!.frame.size.width
            
            // 設置縮放比例
            attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
            
        }
        
        return attributes
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
