//
//  DataService.swift
//  Lesson18
//
//  Created by user on 18.04.2024.
//

import Foundation

class DataService {
    
    private var cachedImageData: [String: Data] = [:]
    
    func write(image data: Data, for url: String) {
        cachedImageData[url] = data
    }
    
    func readData(for url: String) -> Data? {
        return cachedImageData[url] ?? nil
    }
}
