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
            
            // SkShapeNode is a primitive for drawing like with the AS3 Drawing API
            // it has built in support for primitives like a circle, so we pass a radius
            let shapeA = SKShapeNode(circleOfRadius: 20)
            // we set the color and line style
            shapeA.strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
            shapeA.lineWidth = 4
            
            // we set initial random positions
            shapeA.position = CGPoint (x: CGFloat(arc4random()%(canvasWidth)), y: CGFloat(arc4random()%(canvasHeight)))
            // we add each circle to the display list
            self.addChild(shapeA)
        
        // this is the most important line, we define the body
        shapeA.physicsBody = SKPhysicsBody(circleOfRadius: shapeA.frame.size.width/2)
        // this defines the mass, roughness and bounciness
        shapeA.physicsBody.friction = 0.3
        shapeA.physicsBody.restitution = 0.8
        shapeA.physicsBody.mass = 0.5
        // this will allow the balls to rotate when bouncing off each other
        shapeA.physicsBody.allowsRotation = true
        
        // SkShapeNode is a primitive for drawing like with the AS3 Drawing API
        // it has built in support for primitives like a circle, so we pass a radius
        let shapeB = SKShapeNode(circleOfRadius: 20)
        // we set the color and line style
        shapeB.strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.5)
        shapeB.lineWidth = 4
        
        // this is the most important line, we define the body
        shapeB.physicsBody = SKPhysicsBody(circleOfRadius: shapeB.frame.size.width/2)
        // this defines the mass, roughness and bounciness
        shapeB.physicsBody.friction = 0.3
        shapeB.physicsBody.restitution = 0.8
        shapeB.physicsBody.mass = 0.5
        // this will allow the balls to rotate when bouncing off each other
        shapeB.physicsBody.allowsRotation = true
        
        // we set initial random positions
        shapeB.position = CGPoint (x: CGFloat(arc4random()%(canvasWidth)), y: CGFloat(arc4random()%(canvasHeight)))
        // we add each circle to the display list
        self.addChild(shapeB)
        
        
        
            let skLimit = SKPhysicsJointPin()
        skLimit.bodyA = shapeA.physicsBody
        skLimit.bodyB = shapeB.physicsBody
        
            //self.physicsWorld.addJoint(skLimit)
            

    }
    
    // magic of the physics engine, we don't have to do anything here
    override func update(currentTime: CFTimeInterval) {
    }
}