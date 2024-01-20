//
//  ViewController.swift
//  iOS_CoreAnimation_Demo
//
//  Created by simon on 2024/1/20.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    let cellId = "ViewControllerCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Entry"
        view.backgroundColor = UIColor.white
        setupSubView()
    }
    
    func setupSubView(){
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CALength.kNavStatusBarHeight)
            make.left.bottom.right.equalTo(0)
        }
    }
    
    lazy var tableview: UITableView = {
        let tableV:UITableView = UITableView(frame: CGRectZero, style: .plain)
        
        tableV.separatorStyle = .none
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableV.dataSource = self
        tableV.delegate = self
        return tableV
        
    }()

}


extension ViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else{
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "123"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseVC = BaseAnimationVC()
        navigationController?.pushViewController(baseVC, animated: true)
    }
    
}
