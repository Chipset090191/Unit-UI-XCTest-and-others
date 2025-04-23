//
//  Bundle-decodable.swift
//  DeliciousMeal
//
//  Created by Михаил Тихомиров on 19.04.2024.
//

import Foundation

extension Bundle {
    
    func decode(fileName: String) throws -> [Menu] {
        guard let url = self.url(forResource: fileName, withExtension: nil) else {
            throw NSError(domain: "FileNotFound", code: 1)
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Menu].self, from: data)
       

    }
    
}
