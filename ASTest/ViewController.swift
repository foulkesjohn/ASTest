import UIKit
import AsyncDisplayKit

class ViewController: ASViewController {

  init() {
    super.init(node: HeadlinesNode())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
