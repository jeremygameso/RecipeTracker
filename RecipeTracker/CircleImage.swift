//
//  CircleImage.swift
//  
//
//  Created by Lin Zhou on 5/4/20.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var body: some View {
        image
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 16)

    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("TitleDish"))
    }
}
