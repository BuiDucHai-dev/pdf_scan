//
//  Photo.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 02/10/2023.
//

import Foundation
import UIKit

public struct Photo: Identifiable, Equatable {
//    The ID of the captured photo
    public var id: String
//    Data representation of the captured photo
    public var path: URL
    
    public init(id: String = UUID().uuidString, path: URL) {
        self.id = id
        self.path = path
    }
}

extension Photo {
    public var compressedData: Data? {
        ImageResizer(targetWidth: 800).resize(data: originalData)?.jpegData(compressionQuality: 0.5)
    }
    public var thumbnailData: Data? {
        ImageResizer(targetWidth: 50).resize(data: originalData)?.jpegData(compressionQuality: 0.2)
    }
    public var thumbnailImage: UIImage? {
        guard let data = thumbnailData else { return nil }
        return UIImage(data: data)
    }
    public var image: UIImage? {
        guard let data = compressedData else { return nil }
        return UIImage(data: data)
    }
}
