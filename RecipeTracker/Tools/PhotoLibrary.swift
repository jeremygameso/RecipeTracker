//
//  PhotoLibrary.swift
//  RecipeTracker
//
//  Created by Lin Zhou on 5/22/20.
//  Copyright © 2020 Lazy Fish Inc. All rights reserved.
//

import SwiftUI
/*
struct PhotoLibrary: View {
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                  self.showCaptureImageView.toggle()
                }) {
                    Text("Choose photos")
                }
                
                image?.resizable()
                  .frame(width: 250, height: 250)
                  .clipShape(Circle())
                  .overlay(Circle().stroke(Color.white, lineWidth: 4))
                  .shadow(radius: 10)
            }
            if (showCaptureImageView) {
              CaptureImageView(isShown: $showCaptureImageView, image: $image)
            }
        }
    }
}

struct PhotoLibrary_Previews: PreviewProvider {
    static var previews: some View {
        PhotoLibrary()
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
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}
*/
