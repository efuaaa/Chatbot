//
//  ButtonsView.swift
//  Chip- Hotel Booking Chatbot
//
//  Created by user on 25/01/2019.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit
import SnapKit

class ButtonsView: UIView {

    typealias ActionHandler = (_ text: String) -> Void
    
    let offset = CGFloat(15)
    let buttonsOffset = CGFloat(15)
    let borderSize = CGFloat(1)
    let buttonHeight = CGFloat(40)
    let buttonsCornerRadius = CGFloat(10)
    var scrollView: UIScrollView!
    var actionAndler: ActionHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //init scrollView
        scrollView = UIScrollView(frame: CGRect.zero)
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(offset)
            make.bottom.equalTo(self).inset(offset)
            make.right.equalTo(self)
            make.left.equalTo(self)
        }
        
        //setup scroll view content
        let buttonYPosition = CGFloat(0)
        var buttonXPosition = offset
        for button in getButtons() {
            button.frame.origin.y = buttonYPosition
            button.frame.origin.x = buttonXPosition
            scrollView.addSubview(button)
            buttonXPosition = buttonXPosition + button.frame.width + buttonsOffset + (borderSize * 2)
        }
        scrollView.contentSize = CGSize(width: buttonXPosition, height: scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: Get an array of buttons value
    func getButtonsValue(_: String) -> [String] {
        let hello = "Let's get started"
        let forecat = "okay"
        let sanFrancisco = "San Francisco weather"
        let whoAreYou = "Who are you?"
//        let thankYou = "Thank you!"
//        let umbrella = "Will I need an umbrella?"
//        let lifeSense = "What is the sense of the life?"
//        let isGoingTo = "Is going to rain tomorrow in New York?"
       return [hello, forecat, sanFrancisco, whoAreYou]
        
    }
    
    // MARK: Create the buttons array
    func getButtons() -> [UIButton] {
        return getButtonsValue(stringA: ["sas"]).map { label in
            let button = UIButton()
            button.setTitle(label, for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.setTitleColor(.gray, for: .highlighted)
            button.layer.borderWidth = borderSize
            button.layer.borderColor = UIColor.gray.cgColor
            button.layer.cornerRadius = buttonsCornerRadius
            button.sizeToFit()
            button.frame.size.width = button.frame.width + (offset * 2)
            button.frame.size.height = buttonHeight
            button.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
            return button
        }
    }
    
    //MARK: default button action
    @objc func buttonAction(_ sender: UIButton) {
        if actionAndler != nil {
            actionAndler!(sender.titleLabel?.text ?? "unknown label")
        } else {
            print("Error: actionAndler is not defined")
        }
    }
    
    // MARK: Add button action
    func addAction(_ actionAndler: @escaping ActionHandler) {
        self.actionAndler = actionAndler
    }
    

}
