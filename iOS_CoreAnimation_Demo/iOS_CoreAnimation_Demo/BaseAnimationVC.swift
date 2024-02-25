//
//  BaseAnimationVC.swift
//  iOS_CoreAnimation_Demo
//
//  Created by simon on 2024/1/20.
//

import Foundation
import UIKit

@objc(BaseAnimationVC)
@objcMembers class BaseAnimationVC:UIViewController{
    
    //MARK:  Property
    lazy var label:UILabel = {
        let label = UILabel(frame: CGRectMake(100, 100, 100, 100))
        label.text = "1"
        label.backgroundColor = .green
        label.textAlignment = .center
        return label
    }()
    
    
    
    @objc func btnClick(){
        print("click button")
    }
    
    lazy var btn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("2", for: .normal)
        
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.frame = CGRectMake(100, 400, 100, 100)
        btn.backgroundColor = .orange
        return btn
        
//        let label = UILabel(frame: CGRectMake(100, 100, 100, 100))
//        label.text = "1"
//        label.backgroundColor = .green
//        label.textAlignment = .center
//        return label
    }()
    
    
    //MARK: Life Circle
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        
        title = "BaseAnimation"
        view.addSubview(label)
        view.addSubview(btn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = 200
        animation.duration = 1
        
        animation.repeatCount = 1;
        
        //设置以后动画不会返回到初始位置
        animation.isRemovedOnCompletion = false;
        animation.fillMode = .forwards
        
//        label.layer.add(animation, forKey: nil)
//        label.layer.add(animation, forKey: "123")
        
        btn.layer.add(animation, forKey: nil)
//        btn.layer.add(animation, forKey: nil)
        
//        CATransaction.begin()
//        btn.layer.model()
        
//        let transcation = CATransaction()
//        transcation.
//        CATransaction.setAnimationDuration(1.0)
//        CATransaction.setCompletionBlock {
//            self.btn.y = 200
//        }
//        CATransaction.commit()
        
    }
}
