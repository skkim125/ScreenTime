//
//  Bundle+.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/10/24.
//

import Foundation

extension Bundle {
    var apikey: String? {
        return infoDictionary?["API_KEY"] as? String
    }
}
