//
//  HomePageViewController.swift
//  Dtanwang
//
//  Created by liudong on 16/7/6.
//  Copyright © 2016年 lingjing. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, CirCleViewDelegate {
    
    var circleView:CirCleView!
    
    @IBOutlet weak var collectionView: CollectionView!
    
    private var numbers: [Int] = [] // cell 高度
    private var longPressGesture: UILongPressGestureRecognizer!
    
    private var cellContensTuples:([UIImage],[UIImage]) = ([],[])
    
    private var titlesArray: [UIImage] = []
    private var imagesArray: [UIImage] = []
    
    private var sectionArray: [UIImage] = []
    
    var shakeWhenMoveing = false
//    var editing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCirCleView()
        
        self.initCollectionView()
    }
    
    func initCollectionView() {
        for _ in 0...17 {
            let height = 160//Int(arc4random_uniform((UInt32(100)))) + 40
            numbers.append(height)
            

        }
        
        for i in 1...9 {
            titlesArray.append(UIImage(named: "title0\(i)")!)
            imagesArray.append(UIImage(named: "cover0\(i)")!)
        }
        
        for i in 1...9 {
            titlesArray.append(UIImage(named: "title0\(i)")!)
            imagesArray.append(UIImage(named: "cover0\(i)")!)
        }
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(HomePageViewController.handleLongGesture(_:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.Began:
            
            collectionView.startWiggle()
            
            guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
        case UIGestureRecognizerState.Changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
        case UIGestureRecognizerState.Ended:
            collectionView.endInteractiveMovement()
            
            let time: NSTimeInterval = 0.2
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                self.collectionView.stopWiggle()
            }
            
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    func initCirCleView() {
        
//        self.title = "CirCle"
        self.automaticallyAdjustsScrollViewInsets = false
        let imageArray: [UIImage!] = [UIImage(named: "headerImage01"),
                                      UIImage(named: "headerImage02"),
                                      UIImage(named: "headerImage03"),
                                      UIImage(named: "headerImage04")]
        
        let navBarHeight = self.navigationController?.navigationBar.frame.height
        
        self.circleView = CirCleView(frame: CGRectMake(0, navBarHeight!, self.view.frame.size.width, scrollViewHeight), imageArray: imageArray)
        circleView.backgroundColor = UIColor.orangeColor()
        circleView.delegate = self
        self.view.addSubview(circleView)
        
//        let tempButton = UIButton(frame: CGRectMake(0, 300, self.view.frame.size.width, 20))
//        tempButton.backgroundColor = UIColor.redColor()
//        tempButton.setTitle("appendImage", forState: UIControlState.Normal)
//        tempButton.addTarget(self, action: #selector(self.setImage(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(tempButton)
    }

    
    /********************************** Privite Methods ***************************************/
    //MARK:- Privite Methods
    func setImage(sender: UIButton) {
        //        circleView.imageArray = [UIImage(named: "first.jpg"), UIImage(named: "third.jpg")]
        circleView.urlImageArray = ["http://pic1.nipic.com/2008-09-08/200898163242920_2.jpg"]
    }
    
    
    /********************************** Delegate Methods ***************************************/
    //MARK:- Delegate Methods
    //MARK: CirCleViewDelegate Methods
    
    func clickCurrentImage(currentIndxe: Int) {
        print(currentIndxe, terminator: "");
        
        self.performSegueWithIdentifier("HeaderPage", sender: self)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomePageViewController: CHTCollectionViewDelegateWaterfallLayout {
    
    //  cell 间距布局
    func collectionView (collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = CGSize(width: Int((view.bounds.width - 20)/3), height: numbers[indexPath.item])
        print("cell size :\(size)")
        
        return size
    }
    
}

extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! TextCollectionViewCell
//        cell.textLabel.text = "\(numbers[indexPath.item])"
        cell.titleImageView.image = titlesArray[indexPath.item]
        cell.coverImageView.image = imagesArray[indexPath.item]

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let temp = numbers.removeAtIndex(sourceIndexPath.item)
        numbers.insert(temp, atIndex: destinationIndexPath.item)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("点击cell")
        self.performSegueWithIdentifier("CellWebView", sender: self)
    }
}

//MARK: one little trick
extension CHTCollectionViewWaterfallLayout {
    
    internal override func invalidationContextForInteractivelyMovingItems(targetIndexPaths: [NSIndexPath], withTargetPosition targetPosition: CGPoint, previousIndexPaths: [NSIndexPath], previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        
        let context = super.invalidationContextForInteractivelyMovingItems(targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)
        
        self.delegate?.collectionView!(self.collectionView!, moveItemAtIndexPath: previousIndexPaths[0], toIndexPath: targetIndexPaths[0])
        
        return context
    }
}

