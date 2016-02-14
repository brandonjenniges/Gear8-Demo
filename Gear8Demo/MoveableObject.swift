//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import SpriteKit

class MoveableObject: NSObject {
    var isDone = false
    var isBeingTouched = false
    let sprite:SKSpriteNode!
    let blank:SKSpriteNode!
    
    init(image: String, blankImage: String) {
        sprite = SKSpriteNode(imageNamed: image)
        blank = SKSpriteNode(imageNamed: blankImage)
        super.init()
    }
}
