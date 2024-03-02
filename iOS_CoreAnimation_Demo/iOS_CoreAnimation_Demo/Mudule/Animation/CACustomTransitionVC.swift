//
//  CACustomTransitionVC.swift
//  iOS_CoreAnimation_Demo
//
//  Created by simon on 2024/2/29.
//  转场动画,负责翻页,页面跳转效果,图片切换

import Foundation
import UIKit

@objc(CACustomTransitionVC)
class CACustomTransitionVC: BaseVC {
    
    lazy var newView:CACustomTransNewView = {
        let newView = CACustomTransNewView(frame: UIScreen.main.bounds)
        newView.delegate = self
        newView.backgroundColor = .yellow
        return newView
    }()
    
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
        view.bringSubviewToFront(button)
        
        
    }
    
    func showNewViewWithAnimation() {
        view.addSubview(newView)
        //1.创建贝塞尔路径
        newView.isHidden = false
        let startBp = UIBezierPath(ovalIn: self.button.frame)
        let radius = UIScreen.main.bounds.size.height * 1
        let endBP = UIBezierPath(ovalIn: button.frame.insetBy(dx: -radius, dy: -radius))
        
        let startShaper = CAShapeLayer()
        startShaper.path = startBp.cgPath
        let endShaper = CAShapeLayer()
        endShaper.path = endBP.cgPath
        
        let baseAnimation = CABasicAnimation(keyPath: "path")
        baseAnimation.fromValue = startBp.cgPath
        baseAnimation.toValue = endBP.cgPath
        baseAnimation.duration = 0.5
        baseAnimation.setValue("start", forKey: "animationIdentifier")
        newView.layer.mask = endShaper
        endShaper.add(baseAnimation, forKey: "path")
    }
    
    
    func dismissNewViewWithAnimation() {
        
        
        let radius = UIScreen.main.bounds.size.height * 1
        let startBp = UIBezierPath(ovalIn: newView.button.frame.insetBy(dx: -radius, dy: -radius))
        let endBP = UIBezierPath(ovalIn: newView.button.frame)
        
        let startShaper = CAShapeLayer()
        startShaper.path = startBp.cgPath
        let endShaper = CAShapeLayer()
        endShaper.path = endBP.cgPath

        let baseAnimation = CABasicAnimation(keyPath: "path")
        baseAnimation.fromValue = startBp.cgPath
        baseAnimation.toValue = endBP.cgPath
        baseAnimation.duration = 0.5
        baseAnimation.delegate = self
        baseAnimation.setValue("dismiss", forKey: "animationIdentifier")
        
        newView.layer.mask = endShaper
        endShaper.add(baseAnimation, forKey: "path")
    }

    @objc func btnClick(_ btn:UIButton) {
        showNewViewWithAnimation()
    }
    
}
    
    
extension CACustomTransitionVC:CACustomTransNewViewDelegate{
    func newViewBtnDidClick(_ button: UIButton) {

        dismissNewViewWithAnimation()
    }
}
    

extension CACustomTransitionVC:CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let id = anim.value(forKey: "animationIdentifier") as? String{
            
            switch id {
            case "dismiss":
                newView.removeFromSuperview()
            default:
                print()
            }
        }
    }
}
    
//}



/*
 @available(iOS 7.0, *)
 optional func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?

 
 @available(iOS 7.0, *)
 optional func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
 */

//extension CACustomTransitionVC: UINavigationControllerDelegate{
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//
//
//        return nil
//    }

