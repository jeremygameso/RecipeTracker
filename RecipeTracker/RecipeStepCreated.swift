//
//  RecipeStepCreated.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/20/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

struct RecipeStepCreated: View {

    var recipe: Recipe
    @State private var willMoveToNextScreen = false
    
    var body: some View {

        //NavigationView {
            VStack {
                        
                //Spacer()
                //    .frame(height: 50.0)
                
                ResizedCircleImage(image: Image("RecipeIcon"),width: 250,height: 250)
                
                Text("Hooray!\nNew Recipe Step Created!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .blendMode(/*@START_MENU_TOKEN@*/.luminosity/*@END_MENU_TOKEN@*/)
                                
                Button(action: {self.willMoveToNextScreen = true}) {
                    Text("Continue")
                        .font(.headline)
                        .bold()
                        .blendMode(/*@START_MENU_TOKEN@*/.luminosity/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        //.clipShape(Circle())
                        .shadow(radius: 10)
                        //.frame(width: CGFloat(150), height: CGFloat(150))
                }
                
                .padding()
                
                /*
                NavigationLink(destination: RecipeList()) {
                    Text("Start")
                        .font(.title)
                        .bold()
                        .blendMode(/*@START_MENU_TOKEN@*/.luminosity/*@END_MENU_TOKEN@*/)
                }*/
 
            }
            .navigate(to: RecipeDetail(recipe:recipe).environmentObject(UserData()), when: $willMoveToNextScreen)
        //}
    }
}

struct RecipeStepCreated_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCreated()
    }
}
