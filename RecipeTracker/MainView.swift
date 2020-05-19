//
//  ContentView.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/4/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @State private var willMoveToNextScreen = false
    var body: some View {

        //NavigationView {
            VStack {
            
                CircleImage(image: Image("TitleDish"))
                Text("RecipeTracker!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .blendMode(/*@START_MENU_TOKEN@*/.luminosity/*@END_MENU_TOKEN@*/)
                
                Text("From Lazy Fish Inc.")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                    .blendMode(/*@START_MENU_TOKEN@*/.luminosity/*@END_MENU_TOKEN@*/)
                
                Spacer()
                    .frame(height: 50.0)
                                
                Button(action: {self.willMoveToNextScreen = true}) {
                    Text("start")
                        .font(.headline)
                        .bold()
                        .blendMode(/*@START_MENU_TOKEN@*/.luminosity/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension View {

    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<SomeView: View>(to view: SomeView, when binding: Binding<Bool>) -> some View {
        modifier(NavigateModifier(destination: view, binding: binding))
    }
}

// NavigateModifier
fileprivate struct NavigateModifier<SomeView: View>: ViewModifier {

    // Private properties
    fileprivate let destination: SomeView
    @Binding fileprivate var binding: Bool


    // View body
    fileprivate func body(content: Content) -> some View {
        NavigationView {
            ZStack {
                content
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                NavigationLink(destination: destination
                    .navigationBarTitle("")
                    .navigationBarHidden(true),
                               isActive: $binding) {
                    EmptyView()
                }
            }
        }
    }
}
