//
//  CameraEnum.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 02/10/2023.
//

import Foundation

extension CameraService {
    
    public enum SessionSetupResult {
        case success
        case notAuthorized
        case configurationFailed
    }
}

enum CameraPermission {
    case notDetermind
    case granted
    case denied
}
