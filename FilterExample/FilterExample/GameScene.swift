//
//  GameScene.swift
//  FilterExample
//
//  Created by Thibault Imbert on 2014-06-11.
//  Copyright (c) 2014 Thibault Imbert. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // we create the graphics context
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 200, height: 200), true, 1)
        
        // we retrieve it
        var context = UIGraphicsGetCurrentContext()
        
        // we issue drawing commands
        CGContextSetRGBFillColor (context, 1, 1, 0, 1);
        CGContextFillRect (context, CGRectMake (0, 0, 200, 200));// 4
        CGContextSetRGBFillColor (context, 1, 0, 0, 1);// 3
        CGContextFillRect (context, CGRectMake (0, 0, 100, 100));// 4
        CGContextSetRGBFillColor (context, 1, 1, 0, 1);// 3
        CGContextFillRect (context, CGRectMake (0, 0, 50, 50));// 4
        CGContextSetRGBFillColor (context, 0, 0, 1, 0.5);// 5
        CGContextFillRect (context, CGRectMake (0, 0, 50, 100));
        
        // we query an image from it
        var image = UIGraphicsGetImageFromCurrentImageContext()
        
        // we create Core Image context
        var ciContext = CIContext(options: nil)
        // we create a CIImage, think of a CIImage as image data for processing, nothing is displayed or can be displayed at this point
        var coreImage = CIImage(image: image)
        // we pick the filter we want
        var filter = CIFilter(name: "CIGaussianBlur")
        // we pass our image as input
        filter.setValue(coreImage, forKey: kCIInputImageKey)
        // we retrieve the processed image
        var filteredImageData = filter.valueForKey(kCIOutputImageKey) as CIImage
        // returns a Quartz image from the Core Image context
        var filteredImageRef = ciContext.createCGImage(filteredImageData, fromRect: filteredImageData.extent())
        // this is our final UIImage ready to be displayed
        var filteredImage = UIImage(CGImage: filteredImageRef);
        
        // we create a texture, pass the UIImage
        var texture = SKTexture(image: filteredImage)
        // wrap it inside a sprite node
        var sprite = SKSpriteNode(texture:texture)
        // we scale it a bit
        //sprite.setScale(0.5);
        // we position it
        sprite.position = CGPoint (x: 510, y: 380)
        // let's display it
        self.addChild(sprite)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
