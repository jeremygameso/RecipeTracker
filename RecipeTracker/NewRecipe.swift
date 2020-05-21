//
//  NewRecipe.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/13/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

struct NewRecipe: View {

    @EnvironmentObject var userData: UserData
    
    @State private var recipeName: String = ""
    @State private var recipeCategory: String = "long touch to bring up menu"
    
    //@State private var recipeName: String = "first one"
    //@State private var recipeCategory: String = "Entree"

    @State private var showErrorMessage = false
    @State private var willMoveToNextScreen = false
    
    //var a = [String]()
    //let recipeCategoryIdxes: Range = 0...Recipe.Category.allCases.count
    let recipeCategoryIdxes: Range = 0..<Recipe.Category.allCases.count
    
    let destURL = URL(string: "/Users/linzhou/Desktop/software/RecipeTracker/RecipeTracker/Resources")
    
    var body: some View {
        
        VStack {
            Spacer()
            
            Text("Create a New Recipe")
            .bold()
            .font(.title)
            .foregroundColor(Color.gray)
            
            List {
                
                TextField("New Recipe Name", text: $recipeName)
                //Text (String(recipeCategoryIdxes.count))
                Text("Category: \(recipeCategory)")
                    .bold()
                    .foregroundColor(Color.gray)
                    .contextMenu{
                        VStack {
                            ForEach (recipeCategoryIdxes) { idx in
                                Button(action: {self.recipeCategory = Recipe.Category.allCases[idx].rawValue}) {
                                    HStack {
                                        Text(Recipe.Category.allCases[idx].rawValue)
                                        .bold()
                                        .font(.subheadline)
                                        .foregroundColor(Color.gray)
                                    }
                                }
                            }
                        }
                }
                if self.showErrorMessage {
                    Text("Error")
                }
            }
            
            Button(action: {
                if (self.recipeName != "" && self.recipeCategory != "long touch to bring up menu")
                {
                    self.addNewRecipe(recipeName: self.recipeName, recipeCategory: self.recipeCategory)
                    self.willMoveToNextScreen = true
                }
                else {
                    self.showErrorMessage = true
                }
            }) {
                Text("create")
                    .font(.headline)
                    .bold()
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                
            }
            //Text(String(Bundle.main.url(forResource: "RecipeData.json", withExtension: nil)!.absoluteString))
            Spacer()
                .frame(height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
        }
        .navigate(to: RecipeCreated().environmentObject(UserData()),
                  when: $willMoveToNextScreen)
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
    
    func addNewRecipe (recipeName: String, recipeCategory: String){
        
        let identifier = UUID()
        let newRecipe = Recipe(id: identifier, name: recipeName, category: Recipe.Category(rawValue: recipeCategory)!)
        
        RecipeData.append(newRecipe)
        DataExchange.updateJSON(recipeData: RecipeData)
    }
}

struct NewRecipe_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipe()
    }
}



