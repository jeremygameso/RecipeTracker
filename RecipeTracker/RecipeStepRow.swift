//
//  RecipeStepRow.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/13/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

struct RecipeStepRow: View {

    var step: RecipeStep
    
    var body: some View {
        HStack() {
            
            Text (String(step.index))
            .font(.subheadline)
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .clipShape(Circle())
            .shadow(radius: 10)
            .frame(width: 50)

            Text (self.step.title)
            .font(.subheadline)
            .foregroundColor(Color.gray)
            .frame(width: 120)
        }
            .frame(width: 170)//.Frame(width: 400)
    }
}

struct RecipeStepRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeStepRow(step:RecipeData[0].steps[0])
    }
}
