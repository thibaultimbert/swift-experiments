//
//  GameScene.swift
//  RemoteJSON
//
//  Created by Thibault Imbert on 2014-07-12.
//  Copyright (c) 2014 Thibault Imbert. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
   
    var bytes: NSMutableData?
    
    override func didMoveToView(view: SKView) {
        
        // this is our remote end point (similar to URLRequest in AS3)
        let request = NSURLRequest(URL: NSURL(string: "http://bytearray.org/wp-content/projects/json/colors.json"))
        
        // this is what creates the connection and dispatches the varios events to track progression, etc.
        let loader = NSURLConnection(request: request, delegate: self, startImmediately: true)
    }
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
       self.bytes = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        self.bytes?.appendData(conData)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        // we serialize our bytes back to the original JSON structure
        let jsonResult: Dictionary = NSJSONSerialization.JSONObjectWithData(self.bytes, options: NSJSONReadingOptions.MutableContainers, error: nil) as Dictionary<String, AnyObject>
        
        // we grab the colorsArray element
        let results: NSArray = jsonResult["colorsArray"] as NSArray

        // we iterate over each element of the colorsArray array
        for item in results {
            // we convert each key to a String
            var name: String = item["colorName"] as String
            var color: String = item["hexValue"] as String
            println("\(name): \(color)")
        }
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
