//
//  GameScene.swift
//  Swiftris
//
//  Created by Elber Carneiro on 9/23/15.
//  Copyright (c) 2015 Elber Carneiro. All rights reserved.
//

import SpriteKit

// point size of each block sprite (lower resolution)
let BlockSize: CGFloat = 20.0

// constant. This is the slowest speed at which our blocks will travel.
let TickLengthLevelOne = NSTimeInterval(600)

class GameScene: SKScene {
    
    let gameLayer = SKNode()
    let shapeLayer = SKNode()
    // layer position with an offset from the edge of the screen
    let LayerPosition = CGPoint(x: 6, y: -6)
    
    // MARK: Class variables
    // This horrifying thing is a CLOSURE (like a block in ObjC). It takes no 
    // parameters and returns nothing. Also it is an optional (may be nil).
    var tick:(() -> ())?
    
    var tickLengthMillis = TickLengthLevelOne
    var lastTick: NSDate?
    
    var textureCache = Dictionary<String, SKTexture>()
    
    // MARK: Constructors
    // required init for creation in storyboard. We make it so it will throw an 
    // error
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported.")
    }
    
    // the constructor we will use to create the game scene programmatically
    override init(size: CGSize) {
        super.init(size: size)
        
        // in spritekit 0, 0 is the bottom left of the screen. 0, 1 is the top
        // left. We will draw our game from the top left. SpriteKit is based
        // on OpenGL and the coordinate system comes from there.
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        // add a node to handle our background image
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = CGPoint(x: 0, y: 1.0)
        addChild(background)
        
        // gameLayer sits atop the background
        addChild(gameLayer)
        
        let gameBoardTexture = SKTexture(imageNamed: "gameboard")
        let gameBoard = SKSpriteNode(texture: gameBoardTexture, size: CGSizeMake(BlockSize * CGFloat(NumColumns), BlockSize * CGFloat(NumRows)))
        gameBoard.anchorPoint = CGPoint(x: 0, y:1.0)
        gameBoard.position = LayerPosition
        
        // shapeLayer sits atop gameLayer
        shapeLayer.position = LayerPosition
        shapeLayer.addChild(gameBoard)
        gameLayer.addChild(shapeLayer)
        
        // get the soundtrack going
        runAction(SKAction.repeatActionForever(SKAction.playSoundFileNamed("theme.mp3", waitForCompletion: true)))
    }
    
    // MARK: Sound method
    
    // method to play any sound file
    func playSound(sound: String) {
        runAction(SKAction.playSoundFileNamed(sound, waitForCompletion: false))
    }
   
    // MARK: Animation method
    // this is an inherited method of SKScene. This method is calles every frame so 
    // it is excellent for time-keeping
    override func update(currentTime: CFTimeInterval) {
        
        // we check to see if we are in a paused state
        if lastTick == nil {
            return
        }
        
        // otherwise:
        
        // figure out how much time has elapsed. We need the ! b/c lastTick is an
        // optional. This is how you dereference it. The negative value we multiply 
        // it by will give us positive milliseconds
        var timePassed = lastTick!.timeIntervalSinceNow * -1000.0
        
        // if timePassed has exceeded our tick length
        if timePassed > tickLengthMillis {
            // update lastTick to right now
            lastTick = NSDate()
            // call our tick closure if it exists
            tick?()
        }
        
        
        /* NOTE:

            tick?()

        is the same as (shorthand for):

            if tick != nil {
                tick!()
            }

        */

    }
    
    // MARK: Accessor methods to set lastTick
    func startTicking() {
        lastTick = NSDate()
    }
    
    func stopTicking() {
        lastTick = nil
    }
    
    // MARK: Drawing methods
    
    // retuns the precise coordinate of for where a block sprite belongs on the screen. The equations
    // ensure each sprite will be anchored at the block's center.
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        let x: CGFloat = LayerPosition.x + (CGFloat(column) * BlockSize) + (BlockSize / 2)
        let y: CGFloat = LayerPosition.y - ((CGFloat(row) * BlockSize) + (BlockSize / 2))
        return CGPointMake(x, y)
    }
    
    // display preview shape for the first time on the scene. We use a texture cache to
    // hold all the reusable SKTexture objects
    func addPreviewShapeToScene(shape:Shape, completion:() -> ()) {
        for (_, block) in shape.blocks.enumerate() {
            var texture = textureCache[block.spriteName]
            if texture == nil {
                texture = SKTexture(imageNamed: block.spriteName)
                textureCache[block.spriteName] = texture
            }
            let sprite = SKSpriteNode(texture: texture)
            
            // use the pointForColumn method to place the sprites on their correct position. We start it
            // at row - 2 so it begins the animation from above the screen
            sprite.position = pointForColumn(block.column, row: block.row - 2)
            shapeLayer.addChild(sprite)
            block.sprite = sprite
            
            sprite.alpha = 0
            
            // SKActions visually manipulate the SKNode objects. Each block will fade and move
            let moveAction = SKAction.moveTo(pointForColumn(block.column, row: block.row), duration: NSTimeInterval(0.2))
            moveAction.timingMode = .EaseOut
            let fadeInAction = SKAction.fadeAlphaTo(0.7, duration: 0.4)
            fadeInAction.timingMode = .EaseOut
            sprite.runAction(SKAction.group([moveAction, fadeInAction]))
        }
        runAction(SKAction.waitForDuration(0.4), completion: completion)
    }
    
    // moves each block for a given shape
    func movePreviewShape(shape: Shape, completion:() -> ()) {
        for (_, block) in shape.blocks.enumerate() {
            let sprite = block.sprite!
            let moveTo = pointForColumn(block.column, row: block.row)
            let moveToAction: SKAction = SKAction.moveTo(moveTo, duration: 0.2)
            moveToAction.timingMode = .EaseOut
            sprite.runAction(SKAction.group([moveToAction, SKAction.fadeAlphaTo(1.0, duration: 0.2)]), completion: {})
        }
        runAction(SKAction.waitForDuration(0.2), completion: completion)
    }
    
    // redraws each block for a given shape
    func redrawShape(shape: Shape, completion:() -> ()) {
        for (_, block) in shape.blocks.enumerate() {
            let sprite = block.sprite!
            let moveTo = pointForColumn(block.column, row: block.row)
            let moveToAction = SKAction.moveTo(moveTo, duration: 0.05)
            moveToAction.timingMode = .EaseOut
            sprite.runAction(moveToAction, completion: {})
        }
        runAction(SKAction.waitForDuration(0.05), completion: completion)
    }
    
    // MARK: Animation methods
    
    // the parameter is the tuple we get when lines are about to be removed
    func animateCollapsingLines(linesToRemove: Array<Array<Block>>, fallenBlocks: Array<Array<Block>>, completion: ()->()) {
        
        // this variable tells us how long to wait until we call the completion closure
        var longestDuration: NSTimeInterval = 0
        
        // from left to right, column by column, we iterate the animation
        for (columnIdx, column) in fallenBlocks.enumerate() {
            for (blockIdx, block) in column.enumerate() {
                let newPosition = pointForColumn(block.column, row: block.row)
                let sprite = block.sprite!
                
                // the delay will be directly proportional to the block and column index, 
                // so the blocks fall at different rates
                let delay = (NSTimeInterval(columnIdx) * 0.05) + (NSTimeInterval(blockIdx) * 0.05)
                let duration = NSTimeInterval(((sprite.position.y - newPosition.y) / BlockSize) * 0.1)
                let moveAction = SKAction.moveTo(newPosition, duration: duration)
                moveAction.timingMode = .EaseOut
                sprite.runAction(
                    SKAction.sequence([
                        SKAction.waitForDuration(delay),
                        moveAction])
                )
                longestDuration = max(longestDuration, duration + delay)
            }

        }
        
        for (rowIdx, row) in linesToRemove.enumerate() {
            
            for (blockIdx, block) in row.enumerate() {
                
                // we randomize a radius for each block's explosion off the screen 
                // and we randomize the direction in which each block flies off
                let randomRadius = CGFloat(UInt(arc4random_uniform(400) + 100))
                let goLeft = arc4random_uniform(100) % 2 == 0
                
                var point = pointForColumn(block.column, row: block.row)
                point = CGPointMake(point.x + (goLeft ? -randomRadius : randomRadius), point.y)
                
                let randomDuration = NSTimeInterval(arc4random_uniform(2)) + 0.5
                
                // the angles are in radians, or fractions of pi
                var startAngle = CGFloat(M_PI)
                var endAngle = startAngle * 2
                if goLeft {
                    endAngle = startAngle
                    startAngle = 0
                }
                let archPath = UIBezierPath(arcCenter: point, radius: randomRadius, startAngle: startAngle, endAngle: endAngle, clockwise: goLeft)
                let archAction = SKAction.followPath(archPath.CGPath, asOffset: false, orientToPath: true, duration: randomDuration)
                archAction.timingMode = .EaseIn
                let sprite = block.sprite!
                
                // this puts the exploding blocks "above" the other game blocks first, 
                // then runs the animation
                sprite.zPosition = 100
                sprite.runAction(
                    SKAction.sequence(
                        [SKAction.group([archAction, SKAction.fadeOutWithDuration(NSTimeInterval(randomDuration))]), SKAction.removeFromParent()]
                    )
                )
            }
        }
        
        // run the completion block passed in
        runAction(SKAction.waitForDuration(longestDuration), completion: completion)
        
    }
    
    
    
}
