//
//  TestPractice.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/20/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

struct TestPractice: View {
    @State var arr = ["ALFA", "BETA", "GAMA", "DELTA"]
    var body: some View {
        VStack {
        VStack {
            Divider()
            ForEach(arr, id: \.self) { element in
                VStack {
                    Text(element)
                    Divider()
                }
            }
        }
            Spacer()
            Button(action: {
                self.arr.shuffle()
            }) {
                Text("Shuffle")
            }
            Spacer()
        }
    }
}

struct TestPractice_Previews: PreviewProvider {
    static var previews: some View {
        TestPractice()
    }
}
