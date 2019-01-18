//
//  UISpinner.swift
//  UISpinner
//
//  Created by hewenfeng on 2018/9/5.
//  Copyright © 2018年 hust. All rights reserved.
//

import UIKit

class UISpinner: UIView {
    var isClicking=false
    var delegate:UISpinnerDelegate?
    var dataSource:UISpinnerDataSource?
    var rootView:UIView?
    var context:UIViewController?
    var align:Int = 0 //0:左对齐，!0：右对齐
    var table:UITableView=UITableView()
    var title:UILabel=UILabel()
    var arrow:UIImageView=UIImageView()
    var onFold:((_ spinner:UISpinner)->Void)?
    var onUnFold:((_ spinner:UISpinner)->Void)?
    var isDropdown = false
    var dropDownHeight:CGFloat = 0{
        didSet{
            let ld = self.convert(CGPoint(x: 0, y: bounds.height), to: context?.view)
            var navigatorbarHeight = CGFloat(0.0)
            if let height = context?.navigationController?.navigationBar.frame.height{
                navigatorbarHeight = height
            }
            let reset = UIScreen.main.bounds.maxY-UIApplication.shared.statusBarFrame.height-navigatorbarHeight-ld.y
            dropDownHeight = min(reset, dropDownHeight)
        }
    }
    var dropDownWidth:CGFloat = 100{
        didSet{
            dropDownWidth = min(UIScreen.main.bounds.width, dropDownWidth)
        }
    }
    convenience init(context:UIViewController) {
        let point=CGRect(x: 0, y: 0, width: 0, height: 0)
        self.init(frame: point,context:context)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect,context:UIViewController) {
        self.init(frame: frame)
        self.context = context
        self.backgroundColor = .white
        context.view.addSubview(table)
        self.addSubview(title)
        self.addSubview(arrow)
        let ges=UITapGestureRecognizer(target: self, action: #selector(click(recognizer:)))
        self.addGestureRecognizer(ges)
        title.textAlignment = .center
        title.textColor = .black
        arrow.image=UIImage(named: "下箭头灰")
        table.delegate=self
        table.dataSource=self
        table.backgroundColor = .white
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setTitle(p:String) -> Void {
        title.text = p
    }
    func setFont(f:UIFont) -> Void {
        title.font=f
    }
    override var frame: CGRect{
        get{return super.frame}
        set{
            super.frame = newValue
            let line_38 = newValue.width - newValue.height*0.4
            title.frame.size = CGSize(width: line_38, height: newValue.height*0.9)
            title.font = UIFont.systemFont(ofSize: 0.3*newValue.height)
            arrow.frame.size = CGSize(width: newValue.height*0.4, height: newValue.height*0.4)
            title.frame.origin.x = 0
            arrow.frame.origin.x = line_38
            title.center.y = newValue.height/2
            arrow.center.y = newValue.height/2
            arrow.layer.cornerRadius = newValue.width/2
        }
    }
    @objc func click(recognizer:UITapGestureRecognizer) -> Void {
        context?.view.bringSubview(toFront: table)
        calculate()
        if isDropdown {
            fold()
        }else {
            unFold()
        }
    }
    func calculate(){
        let pt = self.convert(CGPoint(x: 0, y: self.frame.height), to: context?.view)
        if(align == 0) {
            self.table.frame.origin = pt
        }
        else{
            self.table.frame.origin = CGPoint(x: pt.x - CGFloat(self.dropDownWidth) + self.frame.width, y: pt.y)
        }
    }
    func fold(){
        isDropdown = false
        onFold?(self)
        UIView.animate(withDuration: 0.2, animations: {
            self.arrow.transform = CGAffineTransform.init(rotationAngle: CGFloat(0))
            self.table.frame.size=CGSize(width: self.dropDownWidth, height: 0)
        })
    }
    func unFold(){
        isDropdown = true
        calculate()
        onUnFold?(self)
        UIView.animate(withDuration: 0.2, animations: {
            self.table.frame.size=CGSize(width: self.dropDownWidth, height: self.dropDownHeight)
            self.arrow.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
        })
    }
    func select(index:Int){
        if(index>=0 && dataSource != nil && index < dataSource!.spinner(table, numberOfRowsInSection: index)){
            title.text = dataSource?.spinner(table, StringforRowAt: IndexPath(row: index, section: 0))
        }
    }
    func reloadData(){
        table.reloadData()
    }
}
extension UISpinner:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource != nil {
            return (dataSource?.spinner(tableView, numberOfRowsInSection: section))!
        }
        else {
            return 0;
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataSource != nil{
            return dataSource!.spinner(tableView, cellForRowAt: indexPath)
        }else {
            return UITableViewCell()
        }
    }
}
extension UISpinner:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if delegate != nil{
            self.delegate?.spinner!(tableView, didSelectRowAt: indexPath)
            self.title.text = self.dataSource?.spinner(tableView, StringforRowAt: indexPath)
            self.click(recognizer: UITapGestureRecognizer())
        }
    }
}
