//
//  ModelData.swift
//  MC2-Team1
//
//  Created by Kim Insub on 2022/05/23.
//

import Foundation
import Combine

// ModelData
final class ModelData: ObservableObject {
    
    //filterPara
    func filterPara(currentChapter: Int, id: Int) -> Paragraph {
        let chapterFileName: String
        switch currentChapter {
        case 0:
            chapterFileName = "chapterOne"
        case 1:
            chapterFileName = "chapterTwo"
        case 2:
            chapterFileName = "chapterThree"
        case 3:
            chapterFileName = "chapterFour"
        case 4:
            chapterFileName = "chapterFive"
        case 5:
            chapterFileName = "chapterSixB"
        case 6:
            chapterFileName = "chapterSixC"
        default :
            chapterFileName = "chapterOne"
        }
        
        let chapter: [Paragraph] = JsonManager.load("\(chapterFileName).json")
        var filteredPara: Paragraph {
            chapter.filter { paragraph in paragraph.id == id }.first!
        }
        return filteredPara
    }
    
    // pastParas
    @Published var pastParas: [[String]] = JsonManager.load("PastPara.json") {
        didSet {
            lastPastParaIndex = pastParas.count
            JsonManager.save(data: pastParas)
        }
    }
    @Published var lastPastParaIndex = 0
    
    // currentChapter
    @Published var currentChapterIndex = 0 {
        didSet {
            UserDefaults.standard.set(currentChapterIndex, forKey: "currentChapter")
            
            switch currentChapterIndex {
            case 0...5:
                dotIndex = currentChapterIndex
            case 6:
                dotIndex = 5
            default :
                dotIndex = 0
            }
        }
    }
    
    @Published var dotIndex = 0
    
    init() {
        switch currentChapterIndex {
        case 0...5:
            dotIndex = currentChapterIndex
        case 6:
            dotIndex = 5
        default :
            dotIndex = 0
        }
    }
    
    let chapterNameArray = ["\"낯선 방\"", "\"백연우\"", "\"최지원\"", "\"치료제\"", "\"갈림길\"", "\"안지민\""]
}
