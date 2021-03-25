//
//  GameScene.swift
//  50mRun
//  main code
//
//  Created by 屋仲駿 on 2021/03/22.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    var counterOne:Int = 0
    var counterTwo:Int = 0
    var counterThree:Int = 0
    var startTime:NSDate = NSDate()
    var footmarkOne:SKSpriteNode = SKSpriteNode(imageNamed: "footmark.png")
    var footmarkTwo:SKSpriteNode = SKSpriteNode(imageNamed: "footmark.png")
    var footmarkThree:SKSpriteNode = SKSpriteNode(imageNamed: "footmark.png")
    
    override func didMove(to view: SKView) {
        print("[debug] didMove - called.")
       
        self.backgroundColor = UIColor.white

        //position footmark
        self.addChild(self.footmarkOne)
        self.footmarkOne.position = CGPoint(x: -150, y: -250)
        
        self.addChild(self.footmarkTwo)
        self.footmarkTwo.position = CGPoint(x: 150, y: -400)
        
        // 基準なので画面には見えない
        self.addChild(self.footmarkThree)
        self.footmarkThree.position = CGPoint(x: 0, y: -self.view!.frame.height)
        self.footmarkThree.alpha = 0
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        counterOne = counterOne + 1
        if counterOne == 1 {
            startTime = NSDate()
        }
        var goolTime = startTime.timeIntervalSinceNow
        let time = String(format: "タイム　%.2f", -1.0 * goolTime)
        print(time)
        
    }
    
    func isGool() -> Bool {
        //　ゴール判定
        if self.footmarkThree.position.y > self.view!.frame.height {
            return true
        }
        return false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("[debug] touchesMoved - called")
        // 基準を動かす
        let movePos = CGPoint(x: self.footmarkThree.position.x, y: self.footmarkThree.position.y + 1)
        let moveTo = SKAction.move(to: movePos, duration: 0)
        self.footmarkThree.run(moveTo)
        //　表示している足跡を点滅させる
        let fadeOutAction = SKAction.fadeOut(withDuration: 0)
        let fadeInAction = SKAction.fadeIn(withDuration: 0)
        let fadeActions = SKAction.sequence([fadeOutAction, fadeInAction])
        self.footmarkOne.run(fadeActions)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.footmarkTwo.run(fadeActions)
        }
        //　ゴールを表示
        if self.isGool() == true {
            counterTwo = counterTwo + 1
            let goolLabel = SKLabelNode()
            
            if counterTwo == 1 {
                goolLabel.text = "ゴール！"
                goolLabel.fontColor = UIColor.black
                goolLabel.fontSize = 128
                goolLabel.position = CGPoint(x: 0, y: 200)
                self.addChild(goolLabel)
                
                let goolTime = startTime.timeIntervalSinceNow
                let time = String(format: "タイム　%.2f", -1.0 * goolTime)
                let timeLabel = SKLabelNode()
                timeLabel.text = time
                timeLabel.fontColor = UIColor.black
                timeLabel.fontSize = 64
                self.addChild(timeLabel)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}
