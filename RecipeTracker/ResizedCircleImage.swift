//
//  ResizedCircleImage.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/12/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

struct ResizedCircleImage: View {
    var image: Image
    var width: Int
    var height: Int
    var body: some View {
        image
        .resizable()
        .frame(width: CGFloat(width), height: CGFloat(height))
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 16)

    }
}

struct ResizedCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        ResizedCircleImage(image: Image("kungpaochicken"),width: 250,height: 250)
    }
}
