//
//  FPLabelNode.swift
//  FPLabelNodeDemo
//
//  Created by Kuo-Chuan Pan on 11/10/15.
//  Copyright © 2015 Kuo-Chuan Pan. All rights reserved.
//

import Foundation
import SpriteKit


extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.max, height: height)
        
        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.width
    }
}


class FPLabelNode : SKNode {
    
    var width : CGFloat         // The width of your FPLabelNode
    var height : CGFloat        // The height of your FLabelNode
    var fontName :String        // Font name
    var fontColor : SKColor     // Font color
    var fontSize : CGFloat      // Font size
    var spacing : CGFloat       // Line space
    var starty : CGFloat = 0    // Start point in y
    let startx : CGFloat = 0    // Start point in x
    
    init(fontNamed: String) {
        self.fontName = fontNamed
        self.fontColor = SKColor.whiteColor()
        self.fontSize = 30
        self.spacing = 20
        self.width = 9999
        self.height = 9999
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // clear all texts
    
    func clear(){
        for child in self.children {
            if child is SKLabelNode {
                child.removeFromParent()
            }
        }
        self.starty = 0
    }
    
    // pushing more texts
    
    func pushTexts(texts:[String]) {
        for text in texts {
            self.pushText(text)
        }
    }
    
    
    // push a string
    
    func pushText(text:String) {
        
        // check the width of the text
        let textWidth = text.widthWithConstrainedHeight(self.fontSize, font: UIFont(name: self.fontName, size: self.fontSize)!)
        
        
        if textWidth >= self.width {
            
            // split the text and then push it.
            
            var txts = [String]()
            var txt: String = ""
            
            for c in text.characters {
                txt += String(c)
                let w = txt.widthWithConstrainedHeight(self.fontSize, font: UIFont(name: self.fontName, size: self.fontSize)!)
                if w >= (self.width - 50) {
                    txts.append(txt)
                    txt = ""
                }
            }
            txts.append(txt)
            for txt in txts {
                self.pushALine(txt)
            }
            
        } else {
            // push the text
            self.pushALine(text)
        }
        
    }
    
    // push a single line of text
    func pushALine(text:String) {
        
        let label = SKLabelNode(fontNamed: self.fontName)
        label.position = CGPoint(x:startx, y:starty)
        label.horizontalAlignmentMode = .Left
        label.verticalAlignmentMode = .Center
        label.text = text
        label.fontSize = self.fontSize
        label.fontColor = self.fontColor
        starty -= (self.spacing * self.fontSize)
        self.addChild(label)
        
        if (-starty > (self.height - fontSize - 10)) {
            self.clear()
        }
    }
}
