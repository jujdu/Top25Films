//
//  UITableViewHeaderFooterView+Extensions.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 14.11.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

extension UITableViewHeaderFooterView {
    convenience init(width: CGFloat, height: CGFloat, text: String?) {
        self.init()
        if let text = text {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            let label = UILabel(frame: CGRect(x: 8, y: height * 0.25, width: width, height: height * 0.5))
            headerView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            label.text = text
            self.addSubview(headerView)
            headerView.addSubview(label)
        }
    }
}
