//
//  LayerTreeVC.swift
//  iOS_CoreAnimation_Demo
//
//  Created by simon on 2024/2/25.
//

import Foundation
import UIKit

@objc(LayerTreeVC)
 @objcMembers class LayerTreeVC:UIViewController{
     
     var displayLink:CADisplayLink?
     
     deinit {
         displayLink?.invalidate()
         displayLink = nil
     }
     
     lazy var view1:UIView = {
         var view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
         view.backgroundColor = .yellow
         return view
     }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        view.addSubview(view1)
        
    }
     
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         beginAnimationOfView1()
         printLayerPresentationAndModelFrame()
         
     }
    
     func printLayerPresentationAndModelFrame(){
         displayLink = CADisplayLink(target: self, selector: #selector(printFrame(_:)))
         displayLink?.add(to: .current, forMode: .default)
         self.perform(#selector(cancelPrint), with: nil, afterDelay: 3)
     }
     
     
     @objc func cancelPrint(){
         displayLink?.invalidate()
     }
     /*
      图层树layer tree实际是包括modelTree,presentationTree,renderTree.model层实际就是layer
      
      presentation 实时的位置, model是layer赋值的时候存储的. 动画的过程中，可以通过presentation访问动态变化的数据
      还有一个render
      presentation:Optional((100.0, 117.97318756580353, 100.0, 100.0))
      model:(100.0, 100.0, 100.0, 100.0)
      presentation:Optional((100.0, 118.53112876415253, 100.0, 100.0))
      model:(100.0, 100.0, 100.0, 100.0)
      presentation:Optional((100.0, 119.0867081284523, 100.0, 100.0))
      model:(100.0, 100.0, 100.0, 100.0)
      presentation:Optional((100.0, 119.63988244533539, 100.0, 100.0))
      model:(100.0, 100.0, 100.0, 100.0)
      */
     @objc func printFrame(_ displayLink:CADisplayLink){
         let pRect = view1.layer.presentation()?.frame
         let mRect = view1.layer.model().frame
         print("presentation:\(String(describing: pRect)) \nmodel:\(mRect)")
     }

    
     func beginAnimationOfView1(){
         let basicA = CABasicAnimation(keyPath: "position.y")
         basicA.fromValue = view1.layer.position.y
         basicA.toValue = view1.layer.position.y + 100
         basicA.duration = 3
         basicA.isRemovedOnCompletion = false
         basicA.fillMode = .forwards;
         view1.layer.add(basicA, forKey: "basicAnimation")
     }
     
     
}
