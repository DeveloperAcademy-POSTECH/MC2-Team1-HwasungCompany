//
//  LanguageEnum.swift
//  MC2-Team1
//
//  Created by peo on 2022/06/15.
//

import Foundation

enum Language {
    case KR
    case CN
    case JP
    case EN
    
    var fileName: String {
        switch self {
        case .KR:
            return "KR"
        case .CN:
            return "CN"
        case .JP:
            return "JP"
        case .EN:
            return "Eng"
        }
    }
}
