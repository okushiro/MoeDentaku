//
//  ViewController.swift
//  萌え電卓
//
//  Created by 奥城健太郎 on 2019/05/16.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var calcLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        display.text = ""
        calcLabel.text = ""
    }
    
    
    var voicePlayer = AVAudioPlayer()
    
    
    //計算用に一時的に数字をここに保存
    var tmpNumber:String = ""
    
    //このフラグが立っていたら元々表示されている数字は消える
    var clearFlag:Bool = false
    
    //イコールマークを消すフラグ
    var equalFlag:Bool = false
    
    //数字を押した後にだけ計算させたい
    var numberFlag:Bool = false
    
    //各ボタンの処理
    
    @IBAction func push0(_ sender: Any) {
        pushNumber(0)
    }
    
    @IBAction func push1(_ sender: Any) {
        pushNumber(1)
    }
    
    @IBAction func push2(_ sender: Any) {
        pushNumber(2)
    }
    
    @IBAction func push3(_ sender: Any) {
        pushNumber(3)
    }
    
    @IBAction func push4(_ sender: Any) {
        pushNumber(4)
    }
    
    @IBAction func push5(_ sender: Any) {
        pushNumber(5)
    }
    
    @IBAction func push6(_ sender: Any) {
        pushNumber(6)
    }
    
    @IBAction func push7(_ sender: Any) {
        pushNumber(7)
    }
    
    @IBAction func push8(_ sender: Any) {
        pushNumber(8)
    }
    
    @IBAction func push9(_ sender: Any) {
        pushNumber(9)
    }
    
    @IBAction func pushPoint(_ sender: Any) {
        voice()
        if clearFlag{
            display.text = ""
        }
        if equalFlag{
            if calcLabel.text == "="{
                calcLabel.text = ""
                equalFlag = false
            }
        }
        if display.text == ""{
            display.text = "0"
        }
        display.text?.append(".")
        clearFlag = false
    }
    
    @IBAction func pushPlus(_ sender: Any) {
        pushSign("+")
    }
    
    @IBAction func pushMinus(_ sender: Any) {
        pushSign("-")
    }
    
    @IBAction func pushTimes(_ sender: Any) {
        pushSign("×")
    }
    
    @IBAction func pushDivide(_ sender: Any) {
        pushSign("÷")
    }
    
    @IBAction func pushEqual(_ sender: Any) {
        pushSign("=")
        equalFlag = true
    }
    
    @IBAction func pushClear(_ sender: Any) {
        voice()
        display.text = ""
        calcLabel.text = ""
        tmpNumber = ""
    }
    
    @IBAction func pushDelete(_ sender: Any) {
        voice()
        if display.text != ""{
            let tmp = display.text!
            let count = tmp.count - 1
            display.text = String(tmp.prefix(count))
            if display.text == ""{
                calcLabel.text = ""
            }
        }
    }
    
    
    ///// function /////
    
    //数字を押した時
    func pushNumber(_ number : Int){
        
        voice()
        
        if clearFlag{
            display.text = ""
        }
        if equalFlag{
            if calcLabel.text == "="{
                calcLabel.text = ""
                equalFlag = false
            }
        }
        if display.text == "0"{
            display.text = ""
        }
        display.text?.append("\(number)")
        clearFlag = false
        numberFlag = true
    }
    
    //符号を押した時
    func pushSign(_ sign : String){
        
        voice()
        
        if display.text == ""{
            return
        }
        
        if !numberFlag{
            calcLabel.text = sign
            return
        }
        
        //イコールの計算
        if tmpNumber != ""{
            let left = Double(tmpNumber)
            let right = Double(display.text!)
            if calcLabel.text == "+"{
                let calc = left! + right!
                toInt(calc)
            }else if calcLabel.text == "-"{
                let calc = left! - right!
                toInt(calc)
            }else if calcLabel.text == "×"{
                let calc = left! * right!
                toInt(calc)
            }else if calcLabel.text == "÷"{
                let calc = left! / right!
                toInt(calc)
            }
        }
        
        calcLabel.text = sign
        clearFlag = true
        numberFlag = false
        tmpNumber = display.text!
    }
    
    //Double型を一部Int型にして表示
    func toInt(_ calc : Double){
        let tmp = round(calc)
        if tmp == calc{
            let int = Int(tmp)
            display.text = String(int)
        }else{
            display.text = String(calc)
        }
    }
    
    //声を流す
    func voice(){
        let random = Int.random(in: 1...35)
        let pathA = Bundle.main.bundleURL.appendingPathComponent("\(random).mp3")
        do{
            voicePlayer = try AVAudioPlayer(contentsOf: pathA, fileTypeHint: nil)
            voicePlayer.play()
        }catch{
            print("エラー発生")
        }
    }
    
}

