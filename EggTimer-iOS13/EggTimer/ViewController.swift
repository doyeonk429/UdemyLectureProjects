//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation // audio 관련 lib

class ViewController: UIViewController {
    // 화면에 있는 UI
    @IBOutlet weak var titleMsg: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Audio player
    var player: AVAudioPlayer!
    
    // timer 관련 변수
    var timer : Timer?
    var totalTime = 0
    var passedTime = 0
    
    // 익힘 정도에 따른 시간 변수
    let eggTimes = ["Soft" : 5, "Medium" : 7, "Hard" : 12]
    let eggTimesforSeconds = ["Soft" : 5*60, "Medium" : 7*60, "Hard" : 12*60]
    
    @IBAction func hardnessSelectors(_ sender: UIButton) {
        
        // 눌린 btn의 title을 받아옴
        let hardness = sender.currentTitle!
        // UI 타이틀 변경
        titleMsg.text = "Egg Countdown Timer!\nType: \(hardness)"
        
        // 변수 초기화
        progressBar.progress = 0.0
        passedTime = 0
        
        // 선택한 익힘 강도 시간 전달
        totalTime = eggTimes[hardness]!
        
        // 타이머 시작
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    // 타이머 진행
    @objc func timerCallback() {
        // 시간 지날 때마다 진행률 조정
        if passedTime < totalTime {
            passedTime += 1
            let percentageProgress = Float(passedTime) / Float(totalTime)
            progressBar.progress = percentageProgress
        } else { // 타이머 끝났을 경우
            timer?.invalidate() // 초기화
            titleMsg.text = "Done!" // UI 메세지 변경
            progressBar.progress = 1.0
            
            // 종료 알림음 재생
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        }
    }
    

}
