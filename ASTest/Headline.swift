import Foundation
import AsyncDisplayKit

struct Headline {
  static func headlines() -> [Headline] {
    return [Headline(),
            Headline()]
  }
}

class HeadlineNode : ASCellNode, Configurable {
    
    override init() {
        super.init()
        self.backgroundColor = .blueColor()
    }
  
  func config(_: Any) {
    
  }
  
}