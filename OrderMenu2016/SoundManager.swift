//
//  SoundManager.swift
//  OrderMenu2016
//
//  Created by zhongdonghang on 16/10/24.
//  Copyright © 2016年 zhongdonghang. All rights reserved.
//

import SpriteKit
//引入多媒体框架
import AVFoundation

class SoundManager :SKNode{
    //申明一个播放器
    var bgMusicPlayer = AVAudioPlayer()
    
    //播放点击的动作音效
    let hitAct = SKAction.playSoundFileNamed("加菜.mp3", waitForCompletion: false)
    
    //播放背景音乐的音效
//    func playBackGround(){
//        //获取apple.mp3文件地址
//        var bgMusicURL:NSURL =  NSBundle.mainBundle().URLForResource("bg", withExtension: "mp3")!
//        //根据背景音乐地址生成播放器
//        bgMusicPlayer=AVAudioPlayer(contentsOfURL: bgMusicURL, fileTypeHint: nil)
//        //设置为循环播放
//        bgMusicPlayer.numberOfLoops = -1
//        //准备播放音乐
//        bgMusicPlayer.prepareToPlay()
//        //播放音乐
//        bgMusicPlayer.play()
//    }
    
    //播放点击音效动作的方法
    func playHit(){
        self.runAction(hitAct)
    }
}
