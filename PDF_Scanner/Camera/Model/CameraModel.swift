//
//  CameraModel.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 02/10/2023.
//

import Combine
import AVFoundation

final class CameraModel: ObservableObject {
    
    private let service = CameraService()
    
    @Published var photo = [Photo]()
    
    var session: AVCaptureSession
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.session = service.session
        
        service.$photo.sink { [weak self] (photo) in
            guard let pic = photo else { return }
            self?.photo.append(pic)
        }
        .store(in: &self.subscriptions)
    }
    
    func setupResult(result: CameraService.SessionSetupResult) {
        service.setupResult = result
    }
    
    func configure() {
        service.configure()
        service.setupResult = .success
    }
    
    func capturePhoto() {
        service.capturePhoto()
    }
    
    func switchFlash() {
        service.toggleTorch()
    }
    
    func zoom(with factor: CGFloat) {
        service.set(zoom: factor)
    }
    
    func stop() {
        service.stop {
            
        }
    }
}
