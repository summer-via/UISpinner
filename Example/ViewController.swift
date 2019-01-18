//
//  ViewController.swift
//  UISpinner
//
//  Created by hewenfeng on 2018/9/5.
//  Copyright © 2018年 hust. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static var rootView:UIView!
    var datas=["001","002","003"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .black
        let spinner=UISpinner(context: self)
        view.addSubview(spinner)
        spinner.frame=CGRect(x: 100, y: 100, width: 100, height: 50)
        spinner.dropDownWidth = 200
        spinner.title.text = "请选择"
        print(spinner.center,spinner.title.center)
        spinner.setFont(f: .systemFont(ofSize: 20))
        spinner.dataSource=self
        spinner.delegate=self
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
    func spinner(_ spinner: UITableView, StringforRowAt indexPath: IndexPath) -> String {
        return datas[indexPath.row]
    }
}
extension ViewController:UISpinnerDelegate{
    func spinner(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath,"click")
    }
}
