//
//  CollectionView.swift
//  Dtanwang
//
//  Created by liudong on 16/7/7.
//  Copyright © 2016年 lingjing. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {
    
    private var isWiggling = false

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
        
    //MARK: 抖动动画
    func startWiggle() {
        for cell in visibleCells() {
            addWiggleAnimationToCell(cell )
        }
        isWiggling = true
    }
    
    func stopWiggle() {
        for cell in visibleCells() {
            cell.layer.removeAllAnimations()
        }
        isWiggling = false
    }
    
    func addWiggleAnimationToCell(cell: UICollectionViewCell) {
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        cell.layer.addAnimation(rotationAnimation(), forKey: "rotation")
        cell.layer.addAnimation(bounceAnimation(), forKey: "bounce")
        CATransaction.commit()
    }
    
    private func rotationAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        let angle = CGFloat(0.04)
        let duration = NSTimeInterval(0.1)
        let variance = Double(0.025)
        animation.values = [angle, -angle]
        animation.autoreverses = true
        animation.duration = self.randomizeInterval(duration, withVariance: variance)
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func bounceAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        let bounce = CGFloat(3.0)
        let duration = NSTimeInterval(0.12)
        let variance = Double(0.025)
        animation.values = [bounce, -bounce]
        animation.autoreverses = true
        animation.duration = self.randomizeInterval(duration, withVariance: variance)
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func randomizeInterval(interval: NSTimeInterval, withVariance variance:Double) -> NSTimeInterval {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random;
    }
    
}
