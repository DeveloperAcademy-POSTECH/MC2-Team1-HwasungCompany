//
//  JsonManager.swift
//  MC2-Team1
//
//  Created by peo on 2022/06/12.
//

import Foundation

final class JsonManager {
    static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    static func saveJsonData<T: Codable>(data: [T]) {
        let jsonEncoder = JSONEncoder()
        
        do {
            let encodedData = try jsonEncoder.encode(data)
            
            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            let fileURL = documentDirectoryUrl.appendingPathComponent("PastPara.json")
            
            do {
                try encodedData.write(to: fileURL)
            }
            catch let error as NSError {
                print(error)
            }
            
            
        } catch {
            print(error)
        }
        
    }
    
    static func loadJsonFile() -> [[String]]? {
        let jsongDecoder = JSONDecoder()
        
        do {
            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
            let fileURL = documentDirectoryUrl.appendingPathComponent("PastPara.json")
            
            let jsonData = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            
            let decodedBigSur = try jsongDecoder.decode([[String]].self, from: jsonData)
            return decodedBigSur
        }
        catch {
            print(error)
            return nil
        }
    }
}
