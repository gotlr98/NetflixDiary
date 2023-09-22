//
//  extensionBundle.swift
//  OTTDiary
//
//  Created by HaeSik Jang on 2023/09/01.
//

import Foundation

extension Bundle {
    
    var apiKey: String {

        guard let filePath = Bundle.main.path(forResource: "Api_Key", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Couldn't find file 'SecureAPIKeys.plist'.")
        }
        
        guard let value = plistDict.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_Key' in 'SecureAPIKeys.plist'.")
        }
        
        
        return value
    }
}
