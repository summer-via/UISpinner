//
//  UISpinnerDataSource.swift
//  UISpinner
//
//  Created by hewenfeng on 2018/9/6.
//  Copyright © 2018年 hust. All rights reserved.
//

import UIKit

protocol UISpinnerDataSource {
    func  spinner(_ spinner: UITableView, numberOfRowsInSection section: Int) -> Int
    
    func spinner(_ spinner: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func spinner(_ spinner:UITableView,StringforRowAt indexPath:IndexPath)->String
}
