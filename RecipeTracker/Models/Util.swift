//
//  Util.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/20/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import Foundation

final class Util {
    
    init() {
    }
    //class func addNewRecipe (recipeName: String, recipeCategory: String){
    //class func deleteRecipe (recipeId: UUID,recipeName: String) {
    
    class func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
}
