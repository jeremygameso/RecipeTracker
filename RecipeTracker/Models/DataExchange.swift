//
//  DataExchange.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/14/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import Foundation

final class DataExchange {
    
    init() {
    }
    //class func addNewRecipe (recipeName: String, recipeCategory: String){
    //class func deleteRecipe (recipeId: UUID,recipeName: String) {
    
    class func updateJSON (recipeData: [Recipe], recipeName: String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(RecipeData)
        let writeData = String(data: data!, encoding: .utf8)!
        //print(writeData)
        let filename = "RecipeData.json"
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        print("This is the file being modifed: add recipe \(recipeName)")
        print(String(Bundle.main.url(forResource: "RecipeData.json", withExtension: nil)!.absoluteString))
        //try! writeData.write(to: file, atomically: false, encoding: .utf8)
        //try! writeData.write(toFile: filename, atomically: false, encoding: .utf8)
        do {
            try writeData.write(to: file, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
        
    }
}
