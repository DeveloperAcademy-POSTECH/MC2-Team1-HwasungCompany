//
//  LocalizeManager.swift
//  MC2-Team1
//
//  Created by peo on 2022/06/15.
//

import Foundation

final class LocalizeManager {
    static func getDeviceLanguage() -> String {
        let preferredLanguage = Locale.preferredLanguages.first
        if preferredLanguage!.contains("ko") {
            return "KR"
        } else if preferredLanguage!.contains("zh") {
            return "CN"
        } else if preferredLanguage!.contains("ja") {
            return "JP"
        } else {
            return "Eng"
        }
    }
}
