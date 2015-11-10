//
//  GameScene.swift
//  FPLabelNodeDemo
//
//  Created by Kuo-Chuan Pan on 11/10/15.
//  Copyright (c) 2015 Kuo-Chuan Pan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let label = FPLabelNode(fontNamed:"Helvetica")
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        label.width = CGRectGetMaxX(self.frame)
        label.height = CGRectGetMaxY(self.frame)
        label.fontColor = SKColor.blackColor()
        label.fontSize = 40
        label.spacing = 1.5
        label.position = CGPoint(x: 20, y: CGRectGetMaxY(self.frame) - 50)
        self.addChild(label)
        
        // Pushing many texts
        label.pushTexts(["Each String will become a line.",
            "If you want to break your String to multi-lines, just split it to an array of String.", "",
            "You can also push a very long string. FPLabelNode will automatically break the string for you, depending on the width of your FPLabelNode."
            ])
        label.pushText("Tap the screen to add more text...")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        label.pushText("You can also push more texts later. If the string exceeds its maximun height, it will automatically clear the previous text for you. ")
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
