//
//  ViewController.swift
//  UISpinner
//
//  Created by hewenfeng on 2018/9/5.
//  Copyright © 2018年 hust. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var datas=["001","002","003"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .black
        let spinner=UISpinner()
        spinner.frame=CGRect(x: 100, y: 100, width: 100, height: 50)
        view.addSubview(spinner)
        spinner.setTitle(p: "测试")
        spinner.setFont(f: .systemFont(ofSize: 20))
        spinner.backgroundColor = .white
        spinner.dataSource=self
        spinner.delegate=self
        spinner.snp.makeConstraints{make in
            make.left.equalTo(view).offset(100)
            make.top.equalTo(view).offset(100)
            make.width.height.equalTo(100)
        }
        print(spinner.frame)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController:UISpinnerDataSource{
    func spinner(_ spinner: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func spinner(_ spinner: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        cell.textLabel?.text=datas[indexPath.row]
        return cell
    }
}
extension ViewController:UISpinnerDelegate{
    func spinner(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath,"click")
    }
}
