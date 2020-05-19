//
//  RecipeDetail.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/12/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

struct RecipeDetail: View {
    
    @EnvironmentObject var userData: UserData
    
    var recipe: Recipe
    @State private var newStepName: String = ""
    @State private var newTimeLimit: String = ""
    
    let isDone: Bool = false
    
    var recipeIndex: Int {
        userData.recipes.firstIndex(where: { $0.id == recipe.id })!
    }
    
    var body: some View {
        
            VStack {
                ResizedCircleImage(image: recipe.image,width: 200,height: 200)
                    //.offset(x: 0, y: -130)
                    //.padding(.bottom, -130)

                VStack(alignment: .leading) {
                    HStack {
                        Text(recipe.name)
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                        
                        Button(action: {
                            self.userData.recipes[self.recipeIndex].isFavorite.toggle()
                        }) {
                            if self.userData.recipes[self.recipeIndex].isFavorite {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                            } else {
                                Image(systemName: "star")
                                    .foregroundColor(Color.gray)
                            }
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color.gray)
                        }
                        
                    }
                    //Text(String(self.userData.recipes[self.recipeIndex].id.uuidString))
                }
                //.offset(x: 0, y: -10)
                NavigationView {
                    VStack {
                    //RecipeStepDetail(stepIdx:1, stepContent: "Test",timeLimit: 200)
                        List {
                            
                            ForEach(0..<self.recipe.steps.count) { idx in
                                NavigationLink(destination: RecipeStepDetail(step:self.recipe.steps[idx],stepIdx:idx+1)) {
                                    RecipeStepRow(step:self.recipe.steps[idx],stepIdx:idx+1)
                                    //Spacer()
                                    Image(systemName: "timer")
                                        .foregroundColor(Color.gray)
                                    if self.recipe.steps[idx].isDone {
                                        Text("Done")
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)
                                    }
                                    else {
                                        Text(self.sec2display(inSec:self.recipe.steps[idx].timeLimit))
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)
                                    }
                                }
                            }//.onDelete(perform: deleteStep)
                            
                            Button(action: {
                            }) {
                                HStack {
                                     Image(systemName: "plus.square.fill")
                                         .resizable()
                                         .frame(width: 25, height: 25)
                                         .foregroundColor(Color.gray)
                                         //.clipShape(Circle())
                                         //.overlay(
                                         //    Circle().stroke(Color.white, lineWidth: 5))
                                         .shadow(radius: 10)
                                         //.offset(x: 15)
                                         .frame(width: 60)
                                    
                                     TextField("New Step Title .........", text: $newStepName)
                                     .font(.subheadline)
                                     .foregroundColor(Color.gray)
                                     .frame(width: 105)
                                     .offset(x: -10)
                                    
                                    Image(systemName: "timer")
                                        .foregroundColor(Color.gray)
                                    TextField("XhourXminXsec", text: $newTimeLimit)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                }
                            }
                            
                        }
                    }
                    //.offset(x: 0, y: -130)
                    .navigationBarTitle(Text(recipe.name), displayMode: .inline)
                    .navigationBarHidden(true)
                    //.padding()
                }
            //.navigationBarTitle(Text("Recipe"), displayMode: .inline)
            //.offset(x: 0, y: -200)
            
            //}
        }
        
    }
    
    func sec2display (inSec: Int) -> String {
        var hour: Int
        var min: Int
        var sec: Int
        var inFull: String = ""
        sec = inSec%60
        min = ((inSec-sec)/60)%60
        hour = (inSec-sec-60*min)/3600
        if hour != 0 {
            inFull = inFull + "\(hour)hour"
        }
        if min != 0 {
            inFull = inFull + "\(min)min"
        }
        if sec != 0 {
            inFull = inFull + "\(min)sec"
        }
        return inFull
    }

    
    //fun addNewStep () {
        
    //}
    
  func deleteStep (at offsets: IndexSet) {
        //print (RecipeData.count)
        //self.recipe.steps.remove(atOffsets: offsets)
        self.userData.recipes[self.recipeIndex].steps.remove(atOffsets: offsets)
        DataExchange.updateJSON(recipeData: self.userData.recipes,recipeName: "")
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: RecipeData[0])
        .environmentObject(UserData())
    }
}
