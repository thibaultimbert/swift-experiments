//
//  GameScene.swift
//  RemoteImage
//
//  Created by Thibault Imbert on 2014-07-13.
//  Copyright (c) 2014 Thibault Imbert. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // our properties
    var bytes: NSMutableData?
    var totalBytes: Float64?
    let label: SKLabelNode = SKLabelNode(fontNamed: "Verdana")
    
    override func didMoveToView(view: SKView) {
        // we create our text label for the preloading infos
        label.position = CGPoint (x: 520, y: 380)
        addChild (label)
        
        // this is our remote end point (similar to URLRequest in AS3)
        let request = NSURLRequest(URL: NSURL(string: "https://s3.amazonaws.com/ooomf-com-files/yvDPJ8ZSmSVob7pRxIvU_IMG_40322.jpg")!)
        
        // this is what creates the connection and dispatches the varios events to track progression, etc.
        let loader = NSURLConnection(request: request, delegate: self, startImmediately: true)
    }
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // we initialize our buffer
        self.bytes = NSMutableData()
        
        // we grab the total bytes expected to load
        totalBytes = Float64(response.expectedContentLength)
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        // we append the bytes as they come in
        self.bytes!.appendData(conData)

        // we calculate our ratio
        // we divide the loaded bytes with the total bytes to get the ratio, we mulitply by 100
        // note that we floor the value
        var ratio = floor((Float64(self.bytes!.length) / totalBytes!) * 100)
        
        // we cast to Int to remove the decimal and concatenate with %
        self.label.text = String (Int(ratio)) + " %"
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // we create a UIImage out of the completed bytes we loaded
        let imageBytes = UIImage(data: self.bytes!)
        
        // we create a texture
        let texture = SKTexture(image: imageBytes!)
        
        // then a sprite
        let sprite = SKSpriteNode(texture: texture)
        
        if let bounds = self.view?.bounds {
        
            // we calculate the ratio so that our image can fit in the canvas size and be scaled appropriately
            var scalingRatio = min (bounds.width/sprite.size.width, bounds.height/sprite.size.height)
        
            // we apply the scaling
            sprite.xScale = scalingRatio
            sprite.yScale = scalingRatio
        
            // we position our image
            sprite.position = CGPoint (x: 510, y: 380)
        
            // we remove the percentage label
            label.removeFromParent()
        
            // we add our final image to the display list
            addChild(sprite)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
