//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Tiago Mamouros on 31/01/2022.
//

import Foundation

extension Bundle {
    func decode<T : Codable >(file : String) -> T{
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to locate \(file) in bundle")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("failed to decode \(file) from bundle")
        }
        
        return decoded
        
    }
}
