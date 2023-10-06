//
//  CameraPreview.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 02/10/2023.
//

import UIKit
import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
             AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
        
        let focusView: UIView = {
            let focusView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            focusView.layer.borderColor = UIColor.white.cgColor
            focusView.layer.borderWidth = 1.5
            focusView.layer.cornerRadius = 25
            focusView.layer.opacity = 0
            focusView.backgroundColor = .clear
            return focusView
        }()
        
        @objc func focusAndExposeTap(gestureRecognizer: UITapGestureRecognizer) {
            let layerPoint = gestureRecognizer.location(in: gestureRecognizer.view)
            let devicePoint = videoPreviewLayer.captureDevicePointConverted(fromLayerPoint: layerPoint)
            
            let focusCircleDiam: CGFloat = 50
            let shiftedLayerPoint = CGPoint(x: layerPoint.x - (focusCircleDiam / 2),
                y: layerPoint.y - (focusCircleDiam / 2))
                        
            focusView.layer.frame = CGRect(origin: shiftedLayerPoint, size: CGSize(width: focusCircleDiam, height: focusCircleDiam))
      
            NotificationCenter.default.post(.init(name: .init("UserDidRequestNewFocusPoint"), object: nil, userInfo: ["devicePoint": devicePoint] as [AnyHashable: Any]))
            
            UIView.animate(withDuration: 0.3, animations: {
                self.focusView.layer.opacity = 1
            }) { (completed) in
                if completed {
                    UIView.animate(withDuration: 0.3) {
                        self.focusView.layer.opacity = 0
                    }
                }
            }
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            
            self.layer.addSublayer(focusView.layer)
            
            let gRecognizer = UITapGestureRecognizer(target: self, action: #selector(VideoPreviewView.focusAndExposeTap(gestureRecognizer:)))
            self.addGestureRecognizer(gRecognizer)
        }
    }
    
    public let session: AVCaptureSession
    
    public init(session: AVCaptureSession) {
        self.session = session
    }
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        view.backgroundColor = .black
        view.videoPreviewLayer.cornerRadius = 0
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.connection?.videoOrientation = .portrait
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
        
    }
}

struct CameraPreview_Previews: PreviewProvider {
    static var previews: some View {
        CameraPreview(session: AVCaptureSession())
            .frame(height: 300)
    }
}
