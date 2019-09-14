//
//  CustomCollectionViewFlowLayout.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/15/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let itemsCountSec0 = collectionView.numberOfItems(inSection: 0)
        let itemsCountSec1 = collectionView.numberOfItems(inSection: 1)
        
        // Imitating paging behaviour
        // Check previous offset and scroll direction
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 { // if velocity.x < 0 -> scroll to left
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage = min(currentPage + 1, itemsCountSec0 - 1 + itemsCountSec1)
        }
        
        // Update offset by using item size + spacing

        var updatedOffset: CGFloat = 0.0
        let offsetForFirstPage = itemSize.width
        
        if currentPage == 1 {
            updatedOffset = offsetForFirstPage
        } else {
            updatedOffset = (itemSize.width + minimumLineSpacing) * CGFloat(currentPage - 1) + offsetForFirstPage
        }
        
        
        previousOffset = updatedOffset
        
        return CGPoint(x: updatedOffset, y: proposedContentOffset.y)
    }
}
