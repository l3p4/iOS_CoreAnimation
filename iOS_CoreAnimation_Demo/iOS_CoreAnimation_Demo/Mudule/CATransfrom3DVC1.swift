//
//  CATransfrom3DVC11.swift
//  iOS_CoreAnimation_Demo
//
//  Created by simon on 2024/2/26.
//

import Foundation
import UIKit

@objc(CATransfrom3DVC1)
class CATransfrom3DVC1:BaseVC{
    
    lazy var view1:UIView = {
        var view = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        view.backgroundColor = .yellow
        let image = UIImage(named: "1")
        view.layer.contents = image?.cgImage
        view.layer.contentsGravity = .resizeAspectFill
        view.layer.contentsScale = UIScreen.main.scale
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var cubeContainer: UIView = {
        let width = CALength.kScreenWidth - 20
        let container = UIView(frame: CGRect(x: 10, y: 400, width: width, height: width))
        container.backgroundColor = .lightGray

        return container
    }()
    
    lazy var cubeViews:Array<UILabel> = {
        var labelArray:[UILabel] = []
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        for i in 0..<6 {
            let label = UILabel(frame: frame)
            label.text = String(i)
            label.backgroundColor = UIColor.random
            
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 30)
//            self.cubeContainer.addSubview(label)
            labelArray.append(label)
        }
        return labelArray
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(view1)
        view.addSubview(cubeContainer)
        

        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        for label in self.cubeViews {
            label.center = CGPoint(x: cubeContainer.width/2.0, y: cubeContainer.height/2.0)
            cubeContainer.addSubview(label)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        transform3DAnimate()

        showCubeVC()
        
//        normalProjection()
        perspectiveProjection()
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    /*
     投影方式:正投影 透视投影(修改m34的值)
     */
    
    //正投影
    func normalProjection(){
        
        var transform = CATransform3DMakeRotation(.pi/4, 0, 1, 0)
        self.view1.layer.transform = transform
    }
    
    //透视投影
    func perspectiveProjection(){
        /*
         CATransform3DIdentity是单位矩阵，该矩阵没有缩放，旋转，歪斜，透视。该矩阵设置到图层上就是设置默认值
         */
//        var transform = CATransform3DIdentity
//        //设置 视觉灭点 跟什么轴没关系
//        transform.m34 = -1/1000.0
//
//
//
//        transform = CATransform3DRotate(transform, .pi/4, 0, 1, 0)
        self.view1.layer.anchorPoint = CGPoint(x: 0, y: 0)
//        var transform1 = CATransform3DMakeRotation(.pi/4, 0, 1, 0)
//        self.view1.layer.transform = transform1
        //背面不渲染,比如绕Y轴旋转180度,就看不到了
//        self.view1.layer.isDoubleSided = false
        //多个subLayer就设置sublayerTransform 这个属性
        //self.view1.layer.sublayerTransform = transform
    }
    
    func transform3DAnimate(){
        var transform = CATransform3DIdentity
        //public func CATransform3DRotate(_ t: CATransform3D, 角度_ angle: CGFloat, 1旋转0不选择_ x: CGFloat, _ y: CGFloat, _ z: CGFloat) -> CATransform3D
        
        //transform = CATransform3DRotate(transform, .pi/4, 0, 1, 0)
        //x y 放大1.5倍
        transform = CATransform3DScale(transform, 1.5, 1.5, 0)
        //平移
        //依赖于已存在的自己的transform,,由于自己的transform,会变化,所以会一直变化
//        transform = CATransform3DTranslate(view1.layer.transform, -100, 0, 0)
        //不依赖于已存在的变换矩阵,而是固定的transform.不会一直变化
        var transform2 = CATransform3DMakeTranslation(-100, 0, 0)
        //效果合并
        transform = CATransform3DConcat(transform, transform2)
        
        
        view1.layer.transform = transform
    }
    
    
    
    
    
    /// cube
    
    
    
    
    func showCubeVC(){
        
        let subView1 = self.cubeViews[1]
        subView1.y -= 100
//        subView1.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        
        subView1.backgroundColor = .red
//        cubeContainer.bringSubviewToFront(subView1)
        subView1.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        var transform1 = CATransform3DRotate(subView1.layer.transform,  .pi/3, 1, 0, 0);
        subView1.layer.transform = transform1;
        
        let subView2 = self.cubeViews[2]
//        subView1.layer.anchorPoint = CGPoint(x: 0, y: 0)
        var transform2 = CATransform3DMakeTranslation(100, 0, 0);
//        var transform1 = CATransform3DMakeRotation( .pi/2, 0, 1, 0);
        subView2.layer.transform = transform2;
        
        let subView3 = self.cubeViews[3]
//        subView1.layer.anchorPoint = CGPoint(x: 0, y: 0)
        var transform3 = CATransform3DMakeTranslation(0, 100, 0);
//        var transform1 = CATransform3DMakeRotation( .pi/2, 0, 1, 0);
        subView3.layer.transform = transform3;
        
        let subView4 = self.cubeViews[4]
//        subView1.layer.anchorPoint = CGPoint(x: 0, y: 0)
        var transform4 = CATransform3DMakeTranslation(-100, 0, 0);
//        var transform1 = CATransform3DMakeRotation( .pi/2, 0, 1, 0);
        subView4.layer.transform = transform4;
        
        
        
        return
        
        //父View的layer图层
        var perspective = CATransform3DIdentity;
        perspective.m34 = -1.0 / 500.0;
        perspective = CATransform3DRotate(perspective, -(.pi/4), 1, 0, 0);
        perspective = CATransform3DRotate(perspective, -(.pi/4), 0, 1, 0);
        self.cubeContainer.layer.sublayerTransform = perspective;
        return
        
        
        //add cube face 1
//        let transform0 = CATransform3DMakeTranslation(0, 0, 100);
//        let subView0 = self.cubeViews[0]
//        subView0.layer.transform = transform0;
        
//        let subView1 = self.cubeViews[1]
//        subView1.layer.anchorPoint = CGPoint(x: 0, y: 0)
////        var transform1 = CATransform3DMakeTranslation(100, 0, 0);
//        var transform1 = CATransform3DMakeRotation( .pi/2, 0, 1, 0);
//        subView1.layer.transform = transform1;
        
//        var transform2 = CATransform3DMakeTranslation(0, -100, 0);
//        transform2 = CATransform3DRotate(transform1, .pi/2, 1, 0, 0);
//        let subView2 = self.cubeViews[2]
//        subView2.layer.transform = transform2;
        
        
        
        
        
        
        
        
        
    }
//
//    func addFace:(NSInteger)index withTransform:(CATransform3D)transform
//    {
//        //获取face视图并将其添加到容器中
//        UIView *face = self.faces[index];
//        [self.containerView addSubview:face];
//
//        //将face视图放在容器的中心
//        CGSize containerSize = self.containerView.bounds.size;
//        face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
//
//
//        //添加transform
//        face.layer.transform = transform;
//
        
        
//    }

}
