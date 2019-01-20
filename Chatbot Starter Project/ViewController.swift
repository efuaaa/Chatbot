//
//  ViewController.swift
//  Chip- Hotel Booking Chatbot
//
//  Created by Sai Kambampati on 9/1/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import ApiAI
import AI
import AVFoundation
import MBProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var chipResponse: UILabel!
    @IBAction func sendMessage(_ sender: Any) {
        
        //let hud = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        
        let request = ApiAI.shared().textRequest()
        
        if let text = self.messageField.text, text != "" {
            request?.query = text
        } else {
            return
        }
        
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
        messageField.text = ""
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
    }

    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

