//
//  RecipeList.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/4/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

struct RecipeList: View {
    
    //@State var showFavoritesOnly = false
    @EnvironmentObject var userData: UserData
    
    @State private var willMoveToAddScreen = false
    
    var body: some View {
        
        NavigationView {

            VStack {
                HStack {
                    Toggle(isOn: $userData.showFavoritesOnly) {
                        Text("Favorites only")
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                    }
                    .frame(width: CGFloat(340))
                }
                /*
                if self.userData.showFavoritesOnly {
                    Text("Favorites only")
                }*/
                List {
                    
                    ForEach(userData.recipes) { recipe in
                        if !self.userData.showFavoritesOnly || recipe.isFavorite {
                            NavigationLink(destination: RecipeDetail(recipe: recipe)) {
                                RecipeRow(recipe: recipe)
                            }
                        }
                    }.onDelete(perform: deleteRecipe)
                    
                    Button(action: {
                        self.willMoveToAddScreen = true
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
                                 .offset(x: 15)
                             Text("    Add new recipe")
                             .font(.subheadline)
                             .foregroundColor(Color.gray)
                             .offset(x: 6)
                        }
                    }
                    
                    /*
                    HStack {
                        
                        NavigationLink(destination: NewRecipe()) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.blue)
                                .clipShape(Circle())
                                //.overlay(
                                //    Circle().stroke(Color.white, lineWidth: 5))
                                .shadow(radius: 16)
                                .offset(x: 15)
                            Text("    Add new recipe")
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                            .offset(x: 15)
                        }
                        //Spacer()
                    }*/
                    //.frame(width: CGFloat(350))
                }

            }
            .navigationBarTitle(Text("Recipes"), displayMode: .inline)
        }
        .navigate(to: NewRecipe().environmentObject(UserData()),
                  when: $willMoveToAddScreen)
    }
    
    func deleteRecipe (at offsets: IndexSet) {
        //print (RecipeData.count)
        self.userData.recipes.remove(atOffsets: offsets)
        DataExchange.updateJSON(recipeData: self.userData.recipes)
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        //RecipeList()
        
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            RecipeList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .environmentObject(UserData())
        }
    }
}

