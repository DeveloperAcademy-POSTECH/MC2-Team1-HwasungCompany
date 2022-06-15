//
//  LocalizeManager.swift
//  MC2-Team1
//
//  Created by peo on 2022/06/15.
//

import Foundation

final class LocalizeManager {
    static var deviceLanguage: Language {
        get {
            if let preferredLanguage = Locale.preferredLanguages.first {
                if preferredLanguage.contains("ko") {
                    return Language.KR
                } else if preferredLanguage.contains("zh") {
                    return Language.CN
                } else if preferredLanguage.contains("ja") {
                    return Language.JP
                } else {
                    return Language.EN
                }
            }
            return Language.EN
        }
    }
    
    static var jsonFileName: String {
        get {
            return deviceLanguage.fileName
        }
    }
}
