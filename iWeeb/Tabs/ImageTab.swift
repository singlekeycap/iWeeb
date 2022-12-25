//
//  ImageTab.swift
//  iWeeb
//
//  Created by Dre Dall'Ara on 12/24/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Photos

struct ImageTab: View {
    @Binding var endpoint : String
    @Binding var url : URL?
    @Binding var saveImage : Bool
    @Binding var failed : Bool
    @Binding var nsfw : Bool
    @Binding var provider : String
    @Binding var imageData : Data
    
    var body: some View {
        VStack() {
            Spacer()
            WebImage(url: url)
                .onSuccess {image, data, cacheType in
                    self.imageData = data!
                }
                .resizable()
                .scaledToFit()
            Spacer()
            HStack {
                Spacer()
                Button("Save Image"){saveImage = true}
                    .alert(isPresented: $saveImage) {
                        Alert(
                            title: Text("Save image?"),
                            message: Text("The on-screen image will be saved to Photos."),
                            primaryButton: .default(
                                Text("Yes"),
                                action: {
                                    PHPhotoLibrary.shared().performChanges({
                                        let request = PHAssetCreationRequest.forAsset()
                                        request.addResource(with: .photo, data: imageData, options: nil)
                                    })
                                }
                            ),
                            secondaryButton: .destructive(
                                Text("No"),
                                action: {self.saveImage = false}
                            )
                        )
                    }
                Spacer()
            }
            Spacer()
            Divider()
            Spacer()
                .frame(height:15)
        }
    }
}
