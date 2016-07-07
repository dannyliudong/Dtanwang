//
//  DraggableCell.swift
//  Dtanwang
//
//  Created by liudong on 16/7/6.
//  Copyright © 2016年 lingjing. All rights reserved.
//

import UIKit

// MARK: DraggableCellDelegate

@objc protocol DraggableCellDelegate {
    optional func draggableCellDeleteButtonTapped(cell: DraggableCell)
    optional func draggableCell(cell: DraggableCell, pannedWithGestureRecognizer gestureRecognizer:UIPanGestureRecognizer)
}

// MARK: DraggableCell

class DraggableCell : UICollectionViewCell, UIGestureRecognizerDelegate {
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    weak var delegate: DraggableCellDelegate?
    
    var editing = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 1.0
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        gesture.maximumNumberOfTouches = 1
        gesture.delegate = self
        self.addGestureRecognizer(gesture)
    }
    
    override func awakeFromNib() {
        deleteButton.transform = CGAffineTransformMakeRotation(CGFloat(45 * M_PI / 180))
    }
    
    func panAction(gesture: UIPanGestureRecognizer) {
        // invoke protocol method
        delegate?.draggableCell?(self, pannedWithGestureRecognizer: gesture)
    }
    
    @IBAction func deleteAction(button: UIButton) {
        // invoke protocol method
        delegate?.draggableCellDeleteButtonTapped?(self)
    }
    
    // MARK: UIGestureRecognizerDelegate
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return !editing;
    }
    
}

