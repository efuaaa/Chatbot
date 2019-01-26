//
//  ViewController.swift
//  Chip- Hotel Booking Chatbot
//
//  Created by Sai Kambampati on 9/1/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import ApiAI

import AVFoundation
import MBProgressHUD

class ViewController: UIViewController {
    
    

    @IBOutlet weak var chipResponse: UILabel!
    @IBOutlet weak var buttonsView: ButtonsView!
    
    @IBAction func reset(_ sender: Any) {
        
        
        buttonsView.isHidden = false
        let source = buttonsView.getButtonsValue()
        let subset = source[0..<source.count-2]
        
        print(subset)
        
//       for i in 1...4
//        {
//
//        let source = buttonsView.getButtonsValue()
//        let subset = source[0..<source.count-i]
//        print(subset)
//
//        }
    }
    
//    func reset()
//    {
//
////        for i in 1...4
////        {
//         buttonsView.isHidden = false
//            let source = buttonsView.getButtonsValue()
//            let subset = source[0..<source.count-2]
//
////          buttonsView.getButtonsValue() = subset
//
////        }
//    }
//
    //  func buttonTextToMessageField(){
        //buttonsView.addAction { text in
      //      self.messageField.text = text
    //    }
    //}
    
    func buttonTextToApi(){
        buttonsView.addAction { text in
            self.newRequest(text)
            let source = self.buttonsView.getButtonsValue(stringA: ["tdfghjn"])
            let subset = source[0..<source.count-2]
            print(subset)
//            ButtonsView.animate(withDuration: 2.5) {
//                self.buttonsView.getButtons().button = .orange
//            }
//          self.buttonsView.removeFromSuperview()
            var sauce : [AnyObject] = source as [AnyObject]
            sauce.append(subset as AnyObject)
          
//            self.buttonsView.
            self.buttonsView.getButtonsValue(stringA: subset)
          
        }
        
    }
    
//    func resetButtons()
//    {
    
       
//
//        buttonsView.isHidden = true
//

//
//
//    }
    
    
    

    
    func newRequest(_ text: String) {
        
        let request = ApiAI.shared().textRequest()
        request?.query = text
        
       
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            if let textResponse = response.result.fulfillment.messages {
                let textRespoArray = textResponse [ 0 ] as NSDictionary
                print(textResponse)
                self.speechAndText(text:textRespoArray.value(forKey: "speech") as! String)
            }
        }, failure: { (request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        
//    buttonsView.isHidden = true
    }
        let speechSynthesizer = AVSpeechSynthesizer()
        
        func speechAndText(text: String) {
            let speechUtterance = AVSpeechUtterance(string: text)
            speechSynthesizer.speak(speechUtterance)
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                self.chipResponse.text = text
            }, completion: nil)
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      buttonTextToApi()
        
    }

    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

