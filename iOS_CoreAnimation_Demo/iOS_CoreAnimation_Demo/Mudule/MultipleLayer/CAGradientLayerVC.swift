//
//  CAGradientLayerVC.swift
//  iOS_CoreAnimation_Demo
//
//  Created by simon on 2024/2/28.
//

import Foundation
import UIKit

@objc(CAGradientLayerVC)
class CAGradientLayerVC:BaseVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawGradientLayer()
        drawGradientLayerForView()
    }
    
    func drawGradientLayer() {
        let gradLayer = CAGradientLayer()
        gradLayer.frame = CGRect(x: 100, y: 150, width: 200, height: 200)
        gradLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        
        gradLayer.startPoint = CGPointMake(0, 0)
        gradLayer.endPoint = CGPointMake(0, 1)
        view.layer.addSublayer(gradLayer)
    }
    
    func drawGradientLayerForView() {
        let view1 = UIView(frame: CGRect(x: 100, y: 400, width: 200, height: 200))
        view1.backgroundColor = .gray
        view.addSubview(view1)
        
        let gradLayer = CAGradientLayer()
        gradLayer.frame = view1.bounds
        gradLayer.colors = [UIColor.green.cgColor, UIColor.blue.cgColor]
        gradLayer.startPoint = CGPointMake(0, 0)
        gradLayer.endPoint = CGPointMake(1, 1)

        view1.layer.addSublayer(gradLayer)
    }
}
