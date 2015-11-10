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

enum FPLabelSplitMode {
    case Character, Word
}

class FPLabelNode : SKNode {
    
    
    var width : CGFloat         // The width of your FPLabelNode
    var height : CGFloat        // The height of your FLabelNode
    var fontName :String        // Font name
    var fontColor : SKColor     // Font color
    var fontSize : CGFloat      // Font size
    var spacing : CGFloat       // Line space
    var buffer : CGFloat        // buffer
    var starty : CGFloat = 0    // Start point in y
    var startx : CGFloat = 0    // Start point in x
    var splitMode : FPLabelSplitMode
    var verticalAlignmentMode : SKLabelVerticalAlignmentMode
    var horizontalAlignmentMode : SKLabelHorizontalAlignmentMode {
        didSet {
            switch horizontalAlignmentMode{
            case .Left:
                self.startx = self.buffer
            case .Center:
                self.startx = self.width / 2.0
            case .Right:
                self.startx = self.width - self.buffer
            }
        }
    }

    
    init(fontNamed: String) {
        self.fontName = fontNamed
        self.fontColor = SKColor.whiteColor()
        self.fontSize = 30
        self.spacing = 1.3
        self.width = 9999
        self.height = 9999
        self.buffer = 80
        self.splitMode = .Word
        self.verticalAlignmentMode = .Center
        self.horizontalAlignmentMode = .Center
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
    
    // Similar to the .text in SKLabelNode.
    
    func pushString(text:String){
        let texts = text.characters.split{$0 == "\n"}.map(String.init)
        for txt in texts {
            self.pushText(txt)
        }
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
            switch self.splitMode{
            case .Character:
                var txts = [String]()
                var txt: String = ""
                
                for c in text.characters {
                    txt += String(c)
                    let w = txt.widthWithConstrainedHeight(self.fontSize, font: UIFont(name: self.fontName, size: self.fontSize)!)
                    if w >= (self.width - self.buffer) {
                        txts.append(txt)
                        txt = ""
                    }
                }
                // append the remaining text
                txts.append(txt)
                for txt in txts {
                    self.pushALine(txt)
                }
            case .Word:
                var txts = [String]()
                var txt : String = ""
                let words = text.characters.split{$0 == " "}.map(String.init)
                for word in words {
                    txt += word + " "
                    let dw = word.widthWithConstrainedHeight(self.fontSize, font: UIFont(name: self.fontName, size: self.fontSize)!)
                    let w = txt.widthWithConstrainedHeight(self.fontSize, font: UIFont(name: self.fontName, size: self.fontSize)!)
                    if w > (self.width - dw - self.buffer) {
                        txts.append(txt)
                        txt = ""
                    }
                }
                // append the remaining text
                txts.append(txt)
                for txt in txts {
                    self.pushALine(txt)
                }
            }
        } else {
            
            self.pushALine(text)
        }
        
    }
    
    // push a single line of text
    func pushALine(text:String) {
        
        let label = SKLabelNode(fontNamed: self.fontName)
        label.position = CGPoint(x:startx, y:starty)
        label.horizontalAlignmentMode = self.horizontalAlignmentMode
        label.verticalAlignmentMode = self.verticalAlignmentMode
        label.text = text
        label.fontSize = self.fontSize
        label.fontColor = self.fontColor
        starty -= (self.spacing * self.fontSize)
        self.addChild(label)
        
        if (-starty > (self.height - self.buffer)) {
            self.clear()
        }
    }
}
