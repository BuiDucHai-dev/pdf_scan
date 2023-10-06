//
//  Filter.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 05/10/2023.
//

import Foundation

public struct Filter: Identifiable, Equatable {
    
    public var id: String
    public var name: String
    public var photo: Photo
    public var type: FilterEnum
    public var isPro: Bool
    
    init(id: String = UUID().uuidString, name: String, photo: Photo, type: FilterEnum, isPro: Bool) {
        self.id = id
        self.name = name
        self.photo = photo
        self.type = type
        self.isPro = isPro
    }
    
    init(id: String = UUID().uuidString, name: String, photo: Photo, type: FilterEnum) {
        self.id = id
        self.name = name
        self.photo = photo
        self.type = type
        self.isPro = false
    }
}
