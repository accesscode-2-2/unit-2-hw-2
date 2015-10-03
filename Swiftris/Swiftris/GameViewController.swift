//
//  GameViewController.swift
//  Swiftris
//
//  Created by Elber Carneiro on 9/23/15.
//  Copyright (c) 2015 Elber Carneiro. All rights reserved.
//

// Tutorial URL: https://www.bloc.io/swiftris-build-your-first-ios-game-with-swift

import UIKit
import SpriteKit

class GameViewController: UIViewController, SwiftrisDelegate, UIGestureRecognizerDelegate {
    
    // This is not an optional value but it is not instantiated til later
    var scene: GameScene!
    var swiftris: Swiftris!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    var panPointReference: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the view controller's default view. The downcasting is
        // necessary to access the SKView properties and methods.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        // create and configure the scene. We give it a value as we promised
        // the compiler
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        // set a closure to this property
        scene.tick = didTick
        
        swiftris = Swiftris()
        swiftris.delegate = self
        swiftris.beginGame()
        
        // present the scene
        skView.presentScene(scene)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    // lowers the falling shape and asks the scene to redraw it
    func didTick() {
        swiftris.letShapeFall()
    }
    
    // MARK: UIGestureRecognizer methods
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        swiftris.rotateShape()
    }
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        
        let currentPoint = sender.translationInView(self.view)
        if let originalPoint = panPointReference {
            
            // if the difference in the x coordinate of the original point and 
            // the current point is greater than a predetermined amount...
            if abs(currentPoint.x - originalPoint.x) > BlockSize * (0.9) {
                
                // if x velocity is positive
                if sender.velocityInView(self.view).x > CGFloat(0) {
                
                    // move shape to the right
                    swiftris.moveShapeRight()
                    // set new reference point
                    panPointReference = currentPoint
                
                // if x velocity is negative
                } else {
                    swiftris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
            
        } else if sender.state == .Began {
            panPointReference = currentPoint
        }
    }
    
    @IBAction func didSwipe(sender: UISwipeGestureRecognizer) {
        swiftris.dropShape()
    }
    
    // MARK: UIGestureRecognizerDelegate methods
    
    // allows multiple gesture recognizers to work in tandem with one another
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // sometimes the multiple gestures will "intersect." We use this optional delegate method
    // to handle such cases
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        // if the casts work, we know which type of recognizer we have...
        
        // if swipe and pan, let pan have priority
        if let swipeRecognizer = gestureRecognizer as? UISwipeGestureRecognizer {
            if let panRecognizer = otherGestureRecognizer as? UIPanGestureRecognizer {
                return true
            }
            
        // if pan and tap, let tap have priority
        } else if let panRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            if let tapRecognizer = otherGestureRecognizer as? UITapGestureRecognizer {
                return true
            }
        }
        return false
    }
    
    func nextShape() {
        let newShapes = swiftris.newShape()
        if let fallingShape = newShapes.fallingShape {
            self.scene.addPreviewShapeToScene(newShapes.nextShape!, completion: {})
            self.scene.movePreviewShape(fallingShape, completion: {
                self.view.userInteractionEnabled = true
                self.scene.startTicking()
            })
        }
    }
    
    // MARK: SwiftrisDelegate methods
    
    func gameDidBegin(swiftris: Swiftris) {
        
        // reset score, level and speed
        levelLabel.text = "\(swiftris.level)"
        scoreLabel.text = "\(swiftris.score)"
        scene.tickLengthMillis = TickLengthLevelOne
        
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(swiftris.nextShape!, completion: {
                self.nextShape()
            })
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftris: Swiftris) {
        view.userInteractionEnabled = false
        scene.stopTicking()
        scene.playSound("gameover.mp3")
        scene.animateCollapsingLines(swiftris.removeAllBlocks(), fallenBlocks: Array<Array<Block>>()) {
            swiftris.beginGame()
        }
    }
    
    func gameDidLevelUp(swiftris: Swiftris) {
        levelLabel.text = "\(swiftris.level)"
        if scene.tickLengthMillis >= 100 {
            scene.tickLengthMillis -= 100
        } else if scene.tickLengthMillis > 50 {
            scene.tickLengthMillis -= 50
        }
        scene.playSound("levelup.mp3")
    }
    
    // this function handles the down swipe, allowing you to speed up its fall
    func gameShapeDidDrop(swiftris: Swiftris) {
        scene.stopTicking()
        scene.redrawShape(swiftris.fallingShape!, completion: {
            swiftris.letShapeFall()
        })
        scene.playSound("drop.mp3")
    }
    
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        self.view.userInteractionEnabled = false
        
        let removedLines = swiftris.removeCompletedLines()
        if removedLines.linesRemoved.count > 0 {
            self.scoreLabel.text = "\(swiftris.score)"
            scene.animateCollapsingLines(removedLines.linesRemoved, fallenBlocks: removedLines.fallenBlocks, completion: {
                self.gameShapeDidLand(swiftris)
            })
            scene.playSound("bomb.mp3")
        } else {
            nextShape()
        }
    }
    
    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(swiftris.fallingShape!, completion: {})
    }
}
