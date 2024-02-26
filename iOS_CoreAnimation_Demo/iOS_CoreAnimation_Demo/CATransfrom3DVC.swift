//
//  CATransfrom3DVC.swift
//  iOS_CoreAnimation_Demo
//
//  Created by simon on 2024/2/26.
//

import Foundation
import UIKit

@objc(CATransfrom3DVC)
class CATransfrom3DVC:UIViewController{
    
    lazy var view1:UIView = {
        var view = UIView(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
        view.backgroundColor = .yellow
        let image = UIImage(named: "1")
        view.layer.contents = image?.cgImage
        view.layer.contentsGravity = .resizeAspectFill
        view.layer.contentsScale = UIScreen.main.scale
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(view1)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        transform3DAnimate()
    }
    
    func transform3DAnimate(){
        var transform = CATransform3DIdentity
        //public func CATransform3DRotate(_ t: CATransform3D, 角度_ angle: CGFloat, 1旋转0不选择_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) -> CATransform3D
        
//        transform = CATransform3DRotate(transform, .pi/4, 0, 1, 0)
        //x y 放大1.5倍
        //transform = CATransform3DScale(transform, 1.5, 1.5, 0)
        //平移
        //依赖于已存在的自己的transform,,由于自己的transform,会变化,所以会一直变化
        transform = CATransform3DTranslate(view1.layer.transform, -100, 0, 0)
        //不依赖于已存在的变换矩阵,而是固定的transform.不会一直变化
        transform = CATransform3DMakeTranslation(-100, 0, 0)
        
        
        view1.layer.transform = transform
    }

}
