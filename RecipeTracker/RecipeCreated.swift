//
//  ContentView.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/4/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

struct RecipeCreated: View {
    
    @State private var willMoveToNextScreen = false
    var body: some View {

        //NavigationView {
            VStack {
                        
                //Spacer()
                //    .frame(height: 50.0)
                
                ResizedCircleImage(image: Image("RecipeIcon"),width: 250,height: 250)
                
                Text("Hooray!\nNew Recipe Created!")
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
            .navigate(to: RecipeList().environmentObject(UserData()),
                      when: $willMoveToNextScreen)
        //}
    }
}

struct RecipeCreated_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCreated()
    }
}
