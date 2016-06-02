import Foundation
import UIKit
import AsyncDisplayKit

class HeadlinesNode: CollectionNodeController <Headline,
                                               HeadlineNode> {
  
  private lazy var timer: NSTimer = {
    return NSTimer(timeInterval: 8.0,
                   target: self,
                   selector: #selector(scrollToNextPage),
                   userInfo: nil,
                   repeats: true)
  }()
  
  init() {
    let collectionViewLayout = CenterCellCollectionViewFlowLayout()
    collectionViewLayout.scrollDirection = .Horizontal
    super.init(collectionViewLayout: collectionViewLayout)
    
    self.usesImplicitHierarchyManagement = true
  }
    
  override func didLoad() {
    super.didLoad()
    
    // Note: Don't access the view of the node before didLoad() is called
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    self.data = Headline.headlines()
    
    NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
  }
  
  override func layoutDidFinish() {
    super.layoutDidFinish()
    
    // 1. Way to fix: Call reloadData() in layoutDidFinish()
    self.collectionNode.reloadData()
    
    // 2. Way to fix: If you use master you should be able to trigger a relayout of items via relayoutItems() that triggers a call to collectionView:constrainedSizeForNodeAtIndexPath:
    //self.collectionNode.view.relayoutItems()
  }
  
  func collectionView(collectionView: ASCollectionView, constrainedSizeForNodeAtIndexPath indexPath: NSIndexPath) -> ASSizeRange {
    // 3. Way to fix: Use the size of the view frame for calculating the width in here. Look into the sourcecode of ASPagerNode as we use the same way in there
    //let size = CGSizeMake(CGRectGetWidth(self.view.frame), 400)
    
    let size = CGSizeMake(CGRectGetWidth(self.collectionNode.frame), 400)
    return ASSizeRangeMake(size, size)
  }
  
  func scrollToNextPage() {
    if self.data.count > 0 {
      self.collectionView.scrollToItemAtIndexPath(self.nextIndexPath(),
                                                  atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally,
                                                  animated: true)
    } else {
      self.timer.invalidate()
    }
  }
  
  private var currentIndexPath = NSIndexPath(forItem: 0, inSection: 0)
  private func nextIndexPath() -> NSIndexPath {
    var nextIndexPath = NSIndexPath(forItem: 0,
                                    inSection: 0)
    let nextIndex = self.currentIndexPath.item + 1
    if nextIndex < self.data.count {
      nextIndexPath = NSIndexPath(forItem: nextIndex,
                                  inSection: 0)
    }
    self.currentIndexPath = nextIndexPath
    return nextIndexPath
  }
  
  override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
    self.collectionNode.position = CGPointZero
    self.collectionNode.sizeRange = ASRelativeSizeRangeMakeWithExactCGSize(constrainedSize.max)
    return ASStaticLayoutSpec(children: [self.collectionNode])
  }
}