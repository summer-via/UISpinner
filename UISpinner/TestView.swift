//
//  TestView.swift
//  UISpinner
//
//  Created by hewenfeng on 2018/9/7.
//  Copyright © 2018年 hust. All rights reserved.
//

import UIKit

class TestView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled=true
        let ges=UITapGestureRecognizer(target: self, action: #selector(click))
        self.addGestureRecognizer(ges)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func  click(){
        print("click")
    }
}
