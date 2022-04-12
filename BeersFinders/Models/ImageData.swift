//
//  ImageData.swift
//  BeersFinders
//
//  Created by Maxence Levelu on 08/04/2022.
//

import Foundation

struct ImageData: Hashable, Identifiable {
    let id = UUID()
    let path: String
    var data: Data? { try? Data(contentsOf: URL(fileURLWithPath: path)) }

    var title: String {
        let fullTitle: NSString = (path as NSString).lastPathComponent as NSString
        let title = fullTitle.deletingPathExtension as String
        return title.capitalized
    }
}

