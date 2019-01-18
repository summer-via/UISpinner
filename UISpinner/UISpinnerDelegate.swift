//
//  UISpinnerDelegate.swift
//  UISpinner
//
//  Created by hewenfeng on 2018/9/6.
//  Copyright © 2018年 hust. All rights reserved.
//

import UIKit

@objc  protocol UISpinnerDelegate {
    @objc optional func spinner(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}
