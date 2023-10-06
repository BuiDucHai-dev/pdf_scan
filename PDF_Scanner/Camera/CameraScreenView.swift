//
//  CameraScreenView.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 28/09/2023.
//

import SwiftUI
import Combine
import AVFoundation

struct CameraScreenView: View {
    
    @State private var cameraPermission: CameraPermission = .notDetermind
    @State var isTourch = false
    @State var isGridShow = false
    @State var isCameraPermissionGranted = false
    
    @State var currentZoomFactor: CGFloat = 1.0
    
    @StateObject var model = CameraModel()
    
    var body: some View {
        GeometryReader {reader in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    if cameraPermission == .notDetermind {
                        Spacer()
                    }
                    if cameraPermission == .granted {
                        ZStack {
                            CameraPreview(session: model.session)
                                .gesture(
                                    DragGesture().onChanged({ (val) in
                                        //  Only accept vertical drag
                                        if abs(val.translation.height) > abs(val.translation.width) {
                                            //  Get the percentage of vertical screen space covered by drag
                                            let percentage: CGFloat = -(val.translation.height / reader.size.height)
                                            //  Calculate new zoom factor
                                            let calc = currentZoomFactor + percentage
                                            //  Limit zoom factor to a maximum of 5x and a minimum of 1x
                                            let zoomFactor: CGFloat = min(max(calc, 1), 5)
                                            //  Store the newly calculated zoom factor
                                            currentZoomFactor = zoomFactor
                                            //  Sets the zoom factor to the capture device session
//                                            model.zoom(with: zoomFactor)
                                        }
                                    })
                                )
                            if isGridShow {
                                GridView()
                            }
                            
                        }
                    } else if cameraPermission == .denied {
                        Spacer()
                        Text("\"TrueScanner” Would Like to Access the Camera")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.primary)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 5.0)
                            .padding(.horizontal, 60.0)
                        
                        Text("The app needs this permission to scan documents with phone’s camera. Without it, this feature cannot work.")
                            .font(.footnote)
                            .fontWeight(.regular)
                            .foregroundColor(Color.primary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 60.0)
                            .padding(.bottom, 10.0)
                        
                        Button {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                                      options: [:], completionHandler: nil)
                        } label: {
                            Text("Go to Settings")
                                .fontWeight(.semibold)
                                .padding(.all, 15.0)
                                .foregroundColor(Color.primary)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    
                    Spacer()
                    CameraBottomControlView(model: model) {
                        model.capturePhoto()
                    } onOpenGalery: {
                        
                    } onMoveNext: {
                        
                    }
                }
            }
        }
        .onAppear() {
            checkCameraPermission()
        }
        .navigationBarItems(trailing: Button(action: {
            isGridShow.toggle()
        }, label: {
            Image(systemName: "squareshape.split.3x3")
            
                .foregroundColor(isGridShow ? Color.yellow : Color.white)
        }))
        .navigationBarItems(trailing: Button(action: {
            isTourch.toggle()
            model.switchFlash()
        }, label: {
            Image(systemName: "flashlight.on.fill")
                .foregroundColor(isTourch ? Color.yellow : Color.white)
        }))
        .background(Color.black.ignoresSafeArea())
        .accentColor(Color.blue)
    }
    
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            cameraPermission = .granted
            model.configure()
            break
        case .notDetermined:
            model.setupResult(result: .configurationFailed)
            cameraPermission = .notDetermind
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
                if granted {
                    cameraPermission = .granted
//                    model.configure()
                } else {
                    cameraPermission = .denied
                }
            })
            break
        default:
            model.setupResult(result: .configurationFailed)
            cameraPermission = .denied
            break
        }
    }
}

extension AVCaptureVideoOrientation {
    init?(deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeRight
        case .landscapeRight: self = .landscapeLeft
        default: return nil
        }
    }
    
    init?(interfaceOrientation: UIInterfaceOrientation) {
        switch interfaceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeLeft
        case .landscapeRight: self = .landscapeRight
        default: return nil
        }
    }
}

extension AVCaptureDevice.DiscoverySession {
    var uniqueDevicePositionsCount: Int {
        
        var uniqueDevicePositions = [AVCaptureDevice.Position]()
        
        for device in devices where !uniqueDevicePositions.contains(device.position) {
            uniqueDevicePositions.append(device.position)
        }
        
        return uniqueDevicePositions.count
    }
}

struct CameraScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreenView()
    }
}
