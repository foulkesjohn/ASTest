import Foundation
import AsyncDisplayKit

struct Headline {
  static func headlines() -> [Headline] {
    return [Headline(),
            Headline()]
  }
}

class HeadlineNode : ASCellNode, Configurable {
  
  func config(_: Any) {
    
  }
  
}