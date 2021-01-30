//
//  UITableView+Extension.swift
//  NABTuanDiep
//
//  Created by Tuan Diep on 1/31/21.
//  Copyright © 2021 Tuan Diep. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        guard let dequeuedCell = dequeueReusableCell(withIdentifier: type.className(), for: indexPath) as? T else {
            fatalError("need to set identifier or register your cell")
        }
        return dequeuedCell
    }
    
    func registerFromNib(forCellClass cellClass: UITableViewCell.Type) {
        register(cellClass.nib(), forCellReuseIdentifier: cellClass.className())
    }
}
