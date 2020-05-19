//
//  RecipeStepDetail.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/14/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI


struct RecipeStepDetail: View {
    
    //@State var currentDate = Date()
    //@State var timeLimit: String
    var step: RecipeStep
    var stepIdx: Int = 1
    var stepContent: String = "Step Title"
    var timeLimit: Int = 3650
    
    @State var inFullSec: Int = 0
    @State var startClick = false
    @State var timeRemaining:String = "Go"
    
    let stopWatchIcon:String = "Go"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        
        //TextField("New Recipe Name", text: $timeLimit)
        VStack() {
            
            HStack {

                Text (String(stepIdx))
                .font(.subheadline)
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 10)

                Text (self.step.title)
                .font(.subheadline)
                .foregroundColor(Color.gray)

                Text (String(stepIdx))
                .font(.subheadline)
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 10)
            }
            
            //Spacer()
            List {
                ForEach(0..<self.step.items.count) { idx in
                    Text (self.step.items[idx].description)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                }//.onDelete(perform: deleteRecipe)
            }
            
            HStack {
            
                Button(action: {
                    self.startClick = !self.startClick
                    if self.timeRemaining == self.stopWatchIcon {
                        self.timeRemaining = self.sec2full(inSec:self.timeLimit)
                    }
                }) {
                    Text("\(timeRemaining)")
                        .font(.subheadline)
                        .bold()
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .onReceive(timer) { _ in
                            self.inFullSec = self.full2sec(inFull:self.timeRemaining)
                            if (self.inFullSec > 0 && self.startClick) {
                                self.inFullSec -= 1
                                self.timeRemaining = self.sec2full(inSec:self.inFullSec)
                                //self.timeRemaining -= 1
                            }
                            else if (self.inFullSec == 0) {
                                self.startClick = false
                            }
                        }
                }
            
                Button(action: {
                    self.timeRemaining = "Go"
                }) {
                    Text("Reset")
                        .font(.subheadline)
                        .bold()
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                
            }
        }
    }
    
    func sec2full (inSec: Int) -> String {
        var hour: Int
        var min: Int
        var sec: Int
        var inFull: String = ""
        sec = inSec%60
        min = ((inSec-sec)/60)%60
        hour = (inSec-sec-60*min)/3600
        if hour != 0 {
            inFull = inFull + "\(hour):"
        }
        if min != 0 || (hour != 0 && min == 0) {
            inFull = inFull + "\(min):"
        }
        inFull = inFull + "\(sec)"
        return inFull
    }
 
    func full2sec (inFull: String) -> Int {
        let inFullTemp: String
        if inFull == self.stopWatchIcon {
            inFullTemp = "0"
        }
        else {
            inFullTemp = inFull
        }
        var hour: Int = 0
        var min: Int = 0
        var sec: Int = 0
        var inSec: Int
        let inParts: [String] = inFullTemp.components(separatedBy: ":")
        if inParts.count == 3 {
            hour=Int(inParts[0])!
            min=Int(inParts[1])!
            sec=Int(inParts[2])!
        }
        else if inParts.count == 2 {
            min=Int(inParts[0])!
            sec=Int(inParts[1])!
        }
        else {
            sec=Int(inParts[0])!
        }
        inSec = hour*3600 + min*60 + sec
        return inSec
    }
    
}

struct RecipeStepDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeStepDetail(step:RecipeData[0].steps[0])
        //RecipeStepDetail(stepIdx:5, stepContent: "Test",timeLimit: 200)
        //.previewLayout(.fixed(width: 300, height: 70))
    }
}
