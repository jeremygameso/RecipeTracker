//
//  RecipeRow.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/4/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

struct RecipeRow: View {
    var recipe: Recipe
    var body: some View {
        HStack {
            recipe.image
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(
                Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            Text(recipe.name)
            .font(.subheadline)
            .foregroundColor(Color.gray)
            .blendMode(/*@START_MENU_TOKEN@*/.luminosity/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            if recipe.isFavorite {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecipeRow(recipe: RecipeData[0])
            RecipeRow(recipe: RecipeData[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
