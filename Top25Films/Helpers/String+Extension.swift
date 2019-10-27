//
//  String+Extention.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 26.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

extension String {
    func convertUrlImageResolution(width: Int, height: Int) -> String {
        let size = "\(width)x\(height)"
        let newString = self.replacingOccurrences(of: "100x100", with: size)
        return newString
    }
}
