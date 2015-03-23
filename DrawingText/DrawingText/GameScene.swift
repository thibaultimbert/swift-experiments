//
//  GameScene.swift
//  DrawingText
//
//  Created by Thibault Imbert on 2014-06-17.
//  Copyright (c) 2014 Thibault Imbert. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        
        // our string, note that we use here NSString instead of String that has more APIs like drawInRect and size
        // it is preferred to use Swift native rypes like String but for now String has a limited API surface
        let text: NSString = "Copyright © - Thibault Imbert"
        
        // we reference our image (path)
        let data = NSData (contentsOfFile: "/Users/timbert/Documents/Ayden.jpg")
        
        // we create a UIImage out of it
        if let image = UIImage(data: data!) {
        
            // our rectangle for the drawing size
            let rect = CGRectMake(0, 0, image.size.width, image.size.height)
        
            // we create our graphics context at the size of our image
            UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.width, height: rect.height), true, 0)
        
            // we retrieve it
            let context = UIGraphicsGetCurrentContext()
            
            // our color
            let color = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 0.5, 0.5, 0.2])
        
            // we set our color to white (this will be the text color)
            CGContextSetFillColorWithColor(context, color)
            
            // we draw our image to the graphics context
            image.drawInRect(rect)
            
            // we pick the font we want to use
            if let font = UIFont(name: "Arial", size: 18) {
        
                // a dictionary informing about the font used, required by sizeWithAttributes to query the text size
                let attr = [NSFontAttributeName: font]

                // the size of our text
                let size = text.sizeWithAttributes(attr)
        
                // the rect for the drawing position of our copyright text message
                let rectText = CGRectMake(image.size.width-size.width, image.size.height-(size.height+4), image.size.width-(size.width+4), image.size.height)
        
                // we draw the text on the graphics context, with our font
                text.drawInRect(rectText, withAttributes: attr)
        
                // we grab a UIImage from the graphics context
                let newImage = UIGraphicsGetImageFromCurrentImageContext();
        
                // we remove our bitmap from the stack
                UIGraphicsEndImageContext();
        
                // we create a texture, pass the UIImage
                var texture = SKTexture(image: newImage)
        
                // wrap it inside a sprite node
                var sprite = SKSpriteNode(texture:texture)
        
                // we scale it a bit
                sprite.setScale(0.5);
        
                // we position it
                sprite.position = CGPoint (x: 510, y: 300)
        
                // let's display it
                self.addChild(sprite)
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
