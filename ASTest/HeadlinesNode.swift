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
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast
    NSRunLoop.currentRunLoop().addTimer(self.timer,
                                        forMode: NSRunLoopCommonModes)
  }
  
  override func interfaceStateDidChange(newState: ASInterfaceState, fromState oldState: ASInterfaceState) {
    if newState.contains(.Display) {
      self.data = Headline.headlines()
    }
  }
  
  func collectionView(collectionView: ASCollectionView, constrainedSizeForNodeAtIndexPath indexPath: NSIndexPath) -> ASSizeRange {
    let size = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 400)
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
    //    let stack = ASStackLayoutSpec.verticalStackLayoutSpec()
    //    stack.setChildren([self.collectionNode])
    //    return stack
  }
}