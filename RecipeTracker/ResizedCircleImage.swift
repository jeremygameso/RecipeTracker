//
//  ResizedCircleImage.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/12/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI

/*
struct ResizedCircleImage: View {
    //var image: Image
    var image: Image? = nil
    var width: Int
    var height: Int
    @State var showCaptureImageView: Bool = false
    
    var body: some View {

        
        image?
        .resizable()
        .frame(width: CGFloat(width), height: CGFloat(height))
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 16)

    }
}
*/

struct ResizedCircleImage: View {
    @State var image: Image? = nil
    var width: Int
    var height: Int
    @State var showCaptureImageView: Bool = false
    
    var body: some View {
        ZStack {
                image?.resizable()
                  .frame(width: 250, height: 250)
                  .clipShape(Circle())
                  .overlay(Circle().stroke(Color.white, lineWidth: 4))
                  .shadow(radius: 10)
            
                Button(action: {
                   self.showCaptureImageView.toggle()
                 }) {
                     //Text("Choose photos")
                     Image(systemName: "pencil")
                         .resizable()
                         .frame(width: 30, height: 30)
                         .foregroundColor(Color.gray)
                         //.clipShape(Circle())
                         //.overlay(
                         // Circle().stroke(Color.white, lineWidth: 5))
                         .shadow(radius: 10)
                         //.offset(x: 15)
                     //.foregroundColor(Color.white)            
            }
            if (showCaptureImageView) {
              CaptureImageView(isShown: $showCaptureImageView, image: $image)
            }
        }
    }
}

struct ResizedCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        ResizedCircleImage(image: Image("kungpaochicken"),width: 250,height: 250)
    }
}

struct CaptureImageView {
    /// TODO 2: Implement other things later
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?

    func makeCoordinator() -> Coordinator {
      return Coordinator(isShown: $isShown, image: $image)
    }
}
extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        //picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}


