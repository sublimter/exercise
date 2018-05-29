//
//  DEMO1ViewController.swift
//  swiftDemo
//
//  Created by luo on 2018/5/29.
//  Copyright © 2018年 luoliangliang. All rights reserved.
//

import UIKit
import SnapKit

class DEMO1ViewController: UIViewController {
    
    var result: UILabel!
    var timer: Timer!
    var labelNumber: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startView = UIView()
        
        result = UILabel()
        self.view.addSubview(result)
        result.textColor = UIColor.black
        result.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX).offset(25)
            make.top.equalTo(100)
        }
        result.font = UIFont.systemFont(ofSize: 30)
        result.text = "0"
        
        startView.backgroundColor = UIColor.init(red: 1, green: 101/255.0, blue: 27/255.0, alpha: 1)
        self.view.addSubview(startView)
        startView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(300)
            make.left.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
            make.width.equalTo(self.view.frame.width / 2)
        }
        
        let startButton:UIButton = UIButton()
        startButton.setTitle("Start", for: UIControlState.normal)
        startView.addSubview(startButton)
        startButton.snp.makeConstraints { (make) in
            make.center.equalTo(startView)
            make.width.height.equalTo(50)
        }
        startButton.addTarget(self, action: #selector(startHandler), for: UIControlEvents.touchUpInside)
        
        let endView = UIView()
        endView.backgroundColor = UIColor.init(red: 98/255.0, green: 242/255.0, blue: 23/255.0, alpha: 1)
        self.view.addSubview(endView)
        endView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(300)
            make.right.equalTo(self.view).offset(0)
            make.width.equalTo(self.view.frame.width / 2)
            make.bottom.equalTo(self.view).offset(0)
        }
        
        let endButton:UIButton = UIButton()
        endButton.setTitle("End", for: UIControlState.normal)
        //        endButton.backgroundColor = UIColor.red
        endView.addSubview(endButton)
        endButton.snp.makeConstraints { (make) in
            make.center.equalTo(endView).offset(0)
            make.width.height.equalTo(50)
        }
        endButton.addTarget(self, action: #selector(stopHandler), for: UIControlEvents.touchUpInside)
        
        let resetButton = UIButton()
        self.view.addSubview(resetButton)
        resetButton.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        resetButton.setTitle("Reset", for: UIControlState.normal)
        resetButton.addTarget(self, action: #selector(resetHandler), for: UIControlEvents.touchUpInside)
    }
    
    @objc func startHandler() {
        if timer != nil {
            stopHandler()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) in
            self.labelNumber = self.labelNumber + 0.1
            self.result.text = String(format: "%.1f", self.labelNumber)
        })
        timer.fire()
    }
    
    @objc func stopHandler() {
        guard let timerForDisplay = timer else {
            return
        }
        timerForDisplay.invalidate()
    }
    
    
    @objc func resetHandler() {
        labelNumber = 0
        result.text = "0"
    }
    
    

}
