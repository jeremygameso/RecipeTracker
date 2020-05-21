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
    
    @State private var willMoveToNextScreen = false
    
    //@State private var listSteps: [RecipeStep] = []
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                            
                            ForEach(self.userData.recipes[self.recipeIndex].steps, id: \.self) { step in
                                NavigationLink(destination: RecipeStepDetail(step:step)) {
                                    RecipeStepRow(step:step)
                                    //Spacer()
                                    Image(systemName: "timer")
                                        .foregroundColor(Color.gray)
                                    if step.isDone {
                                        Text("Done")
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)
                                    }
                                    else {
                                        Text(self.sec2display(inSec:step.timeLimit))
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)
                                    }
                                }
                            }
                            .onDelete(perform: deleteStep)
                            .onReceive(timer) { _ in }
                            //.onReceive(publisher: timer, perform: refresh)
                            //.onReceive(perform: refresh)
                            
                            //Button(action: {
                            //}) {
                            HStack {
                                Button(action: {
                                    if self.newStepName != "" && self.newTimeLimit != "" {
                                        self.addNewStep(newStepName: self.newStepName, newTimeLimit: self.newTimeLimit)
                                        self.newStepName = ""
                                        self.newTimeLimit = ""
                                        self.willMoveToNextScreen = true
                                    }
                                }) {
                                     Image(systemName: "plus.square.fill")
                                         .resizable()
                                         .frame(width: 30, height: 30)
                                         .foregroundColor(Color.gray)
                                         //.clipShape(Circle())
                                         //.overlay(
                                         //    Circle().stroke(Color.white, lineWidth: 5))
                                         .shadow(radius: 10)
                                         //.offset(x: 15)
                                         .frame(width: 60)
                                        .offset(x: -7.5)
                                }
                                
                                 TextField("New Step Title .........", text: $newStepName)
                                 .font(.subheadline)
                                 .foregroundColor(Color.gray)
                                 .frame(width: 105)
                                 .offset(x: -5)
                                
                                Image(systemName: "timer")
                                    .foregroundColor(Color.gray)
                                
                                TextField("XhourXminXsec", text: $newTimeLimit)
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                            }
                            //}
                            
                        }                    

                    }
                    //.offset(x: 0, y: -130)
                    .navigationBarTitle(Text(recipe.name), displayMode: .inline)
                    .navigationBarHidden(true)
                    //.padding()
                }
        }
        //.navigate(to: RecipeDetail(recipe: recipe).environmentObject(UserData()), when: $willMoveToNextScreen)
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
            inFull = inFull + "\(sec)sec"
        }
        return inFull
    }
    
  func deleteStep (at offsets: IndexSet) {
        //print (RecipeData.count)
        //self.recipe.steps.remove(atOffsets: offsets)
        self.userData.recipes[self.recipeIndex].steps.remove(atOffsets: offsets)
        //for (index, step) in self.userData.recipes[self.recipeIndex].steps.enumerated() {
        //    step.index = index
        //}
        for index in 0..<self.userData.recipes[self.recipeIndex].steps.count {
            self.userData.recipes[self.recipeIndex].steps[index].index = index+1
        }
        DataExchange.updateJSON(recipeData: self.userData.recipes)
    }
    
    func refresh () {
        print ("refresh")
        self.userData.recipes[self.recipeIndex].steps = RecipeData[self.recipeIndex].steps
    }
    
    func addNewStep (newStepName: String, newTimeLimit: String){
        
        let identifier = UUID()
        var newTimitLimitSec: Int = 0
        var hour: Int = 0
        var min: Int = 0
        var sec: Int = 0
        var matched: [String] = []
        //let string = "🇩🇪€4€9"
        if newTimeLimit.contains("hour") {
            matched = Util.matches(for: "[0-9]+hour", in: newTimeLimit)
            hour = Int(matched[0].replacingOccurrences(of: "hour", with: ""))!
        }
        
        if newTimeLimit.contains("min") {
            matched = Util.matches(for: "[0-9]+min", in: newTimeLimit)
            min = Int(matched[0].replacingOccurrences(of: "min", with: ""))!
        }
        //min = Int(matched[0])!
        if newTimeLimit.contains("sec") {
            matched = Util.matches(for: "[0-9]+sec", in: newTimeLimit)
            sec = Int(matched[0].replacingOccurrences(of: "sec", with: ""))!
        }
        //print (matched)
        //sec = Int(matched[0])!
        print (hour)
        print (min)
        print (sec)
        //do {
        newTimitLimitSec = hour*3600 + min*60 + sec // calculation not correct
        //} catch let error {
        //    print("invalid regex: \(error.localizedDescription)")
        //}
        print (newTimitLimitSec)
            
        let newList = RecipeStep(id: identifier, title: newStepName, timeLimit: newTimitLimitSec, index: self.userData.recipes[self.recipeIndex].steps.count+1)
        //RecipeData[].steps.append(newList)
        //self.recipe.steps.append(newList)
        self.userData.recipes[self.recipeIndex].steps.append(newList)
        //RecipeData.append(newRecipe)
        DataExchange.updateJSON(recipeData: self.userData.recipes)
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: RecipeData[0])
        .environmentObject(UserData())
    }
}
