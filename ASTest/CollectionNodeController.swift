import Foundation
import UIKit
import AsyncDisplayKit

protocol Configurable {
  func config(_: Any)
}

class CollectionNodeController<T, Cell: ASCellNode where Cell: Configurable>: ASDisplayNode,
                                                                              ASCollectionDataSource,
                                                                              ASCollectionDelegate {
  let collectionNode: ASCollectionNode
  
  init(collectionViewLayout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
    self.collectionNode = ASCollectionNode(collectionViewLayout: collectionViewLayout)
    super.init()
    self.collectionNode.delegate = self
    self.collectionNode.dataSource = self
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.data.count
  }
  
  func collectionView(collectionView: ASCollectionView, nodeBlockForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
    let data = self.data[indexPath.row]
    return {
      let cell = Cell()
      cell.config(data)
      return cell
    }
  }
  
  var collectionView: UICollectionView {
    return self.collectionNode.view
  }
  
  var data = [T]() {
    didSet {
      self.collectionView.reloadData()
    }
  }
}
