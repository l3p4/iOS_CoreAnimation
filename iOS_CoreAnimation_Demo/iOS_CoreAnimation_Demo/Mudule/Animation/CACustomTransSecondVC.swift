//
//  CACustomTransSecondVC.swift
//  iOS_CoreAnimation_Demo
//
//  Created by simon on 2024/2/29.
//  转场动画,负责翻页,页面跳转效果,图片切换

import Foundation
import UIKit

@objc(CACustomTransSecondVC)
class CACustomTransSecondVC: BaseVC {
    
    lazy var button:UIButton = {
        let btn:UIButton = UIButton(type: .custom)
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        btn.setTitle("点击", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.red, for: .highlighted)
        btn.layer.cornerRadius = 40
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        return btn
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.delegate = self
        setupSubView()
    }
    
    func setupSubView() {
        
        let bgImageView = UIImageView(image: UIImage(named: "1"))
        bgImageView.frame = CGRect(x: 0, y: 0, width: CALength.kScreenWidth, height: CALength.kScreenHeight)
        self.view.addSubview(bgImageView)
        
        return

        let maskStartBP = UIBezierPath(ovalIn: button.frame)
        let radius = UIScreen.main.bounds.size.height - 100
        let maskFinalBP = UIBezierPath(ovalIn: button.frame.insetBy(dx: -radius, dy: -radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskFinalBP.cgPath
        maskLayer.backgroundColor = UIColor.white.cgColor
        bgImageView.layer.mask = maskLayer

        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = maskStartBP.cgPath
        maskLayerAnimation.toValue = maskFinalBP.cgPath
        // 时间
        maskLayerAnimation.duration = 5.0
//        maskLayerAnimation.delegate = self
        maskLayer.add(maskLayerAnimation, forKey: "scaleOut")
    }
    
    
    func setupSubView1() {

    }
    
    @objc func btnClick(_ btn:UIButton) {
        
    }
}



/*
 @available(iOS 7.0, *)
 optional func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?

 
 @available(iOS 7.0, *)
 optional func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
 */

extension CACustomTransSecondVC: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return nil
    }
}
