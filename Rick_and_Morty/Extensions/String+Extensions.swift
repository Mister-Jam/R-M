//
//  String+Extensions.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 09/07/2024.
//

import Foundation

extension String {
    static let emptyString = ""
}

extension String? {
    var isNotNil: Bool {
        self != nil
    }
}
