//
//  YPImagePicker.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/11.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import YPImagePicker

extension YPImagePicker {
    func handleSinglePhoto(complete: @escaping (UIImage) -> ()) {
        self.didFinishPicking { [unowned self] items, cancelled in
            if cancelled {
                self.dismiss(animated: true, completion: nil)
            }
            
            if let photo = items.singlePhoto {
                if let editPhoto = photo.modifiedImage {
                    complete(editPhoto.withRenderingMode(.alwaysOriginal))
                    self.dismiss(animated: true, completion: nil)
                } else {
                    complete(photo.image.withRenderingMode(.alwaysOriginal))
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}


extension YPImagePickerConfiguration {
    mutating func singlePhotoConfig() {
        self.screens = [.library,.photo]
        self.library.maxNumberOfItems = 0
        self.startOnScreen = .library
        self.shouldSaveNewPicturesToAlbum = false
    }
}
