// Consider this your Main class, basically the Stage
// Note: The code below is for iOS, you can run it with the iOS simulator

// this imports higher level APIs like Starling
import SpriteKit

// canvas size for the positioning
let canvasWidth: UInt32 = 800
let canvasHeight: UInt32 = 800

// our main logic inside this class
// we subclass the SKScene class by using the :TheType syntax below
class GameScene: SKScene {
    
    // this gets triggered automatically when presented to the view, put initialization logic here
    override func didMoveToView(view: SKView) {
        
        // we set the background color to black, self is the equivalent of this in Flash
        self.scene.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        // we live in a world with gravity on the y axis
        self.physicsWorld.gravity = CGVectorMake(0, -6)
        // we put contraints on the top, left, right, bottom so that our balls can bounce off them
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        // we set the body defining the physics to our scene
        self.physicsBody = physicsBody
        
        // let's create 20 bouncing balls
        for i in 1..30 {
            
            // SkShapeNode is a primitive for drawing like with the AS3 Drawing API
            // it has built in support for primitives like a circle, so we pass a radius
            let shape = SKShapeNode(circleOfRadius: 20)
            // we set the color and line style
            shape.strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
            shape.lineWidth = 4
            // we create a text node to embed text in our ball
            let text = SKLabelNode(text: String(i))
            // we set the font
            text.fontSize = 9.0
            // we nest the text label in our ball
            shape.addChild(text)
            
            // we set initial random positions
            shape.position = CGPoint (x: CGFloat(arc4random()%(canvasWidth)), y: CGFloat(arc4random()%(canvasHeight)))
            // we add each circle to the display list
            self.addChild(shape)
            
            // this is the most important line, we define the body
            shape.physicsBody = SKPhysicsBody(circleOfRadius: shape.frame.size.width/2)
            // this defines the mass, roughness and bounciness
            shape.physicsBody.friction = 0.3
            shape.physicsBody.restitution = 0.8
            shape.physicsBody.mass = 0.5
            // this will allow the balls to rotate when bouncing off each other
            shape.physicsBody.allowsRotation = true
        }
    }
    
    // magic of the physics engine, we don't have to do anything here
    override func update(currentTime: CFTimeInterval) {
    }
}