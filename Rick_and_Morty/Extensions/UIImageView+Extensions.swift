//
//  UIImageView+Extensions.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 09/07/2024.
//

import UIKit
import Kingfisher
import SwiftUI

extension UIImageView {
    public func setImage(
        with imageUrlString: String,
        placeholderImage: UIImage?) {
            let imageUrl = URL(string: imageUrlString)
            let processor = RoundCornerImageProcessor(cornerRadius: 20)
            self.kf.indicatorType = .activity
            self.kf.setImage(with: imageUrl,
                             placeholder: UIImage(named: "placeholderImage"),
                             options: [
                                .processor(processor),
                                .transition(.fade(0.25)), .processor(processor),
                                .cacheOriginalImage
                             ]
            )
        }
}

struct APIImage: View {
    var imageUrl: URL?
    
    init(imageUrl: URL? = nil) {
        self.imageUrl = imageUrl
    }
    
    let processor = RoundCornerImageProcessor(cornerRadius: 20)
    var body: some View {
        
        KFImage.url(imageUrl)
            .placeholder({
                ProgressView()
            })
            .resizable()
            .setProcessor(processor)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in  }
            .onSuccess { result in  }
            .onFailure { error in }
    }
}
