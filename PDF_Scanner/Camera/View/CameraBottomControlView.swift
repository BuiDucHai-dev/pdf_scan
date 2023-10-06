//
//  CameraBottomControlView.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 29/09/2023.
//

import SwiftUI

struct CameraBottomControlView: View {
    
    @State var model: CameraModel
    
    @State var singleMode = true
    
    var onCapture: () -> ()
    var onOpenGalery: () -> ()
    var onMoveNext: () -> ()
    
    let tempView: some View = RoundedRectangle(cornerRadius: 10)
        .frame(width: 86, height: 58, alignment: .center)
        .foregroundColor(.black)
    
    let buttonGallery: some View = VStack {
        Image(systemName: "photo")
            .foregroundColor(Color.white)
        Text("Gallery")
            .font(.subheadline)
            .foregroundColor(.white)
    }
    
    let buttonCapture: some View = ZStack {
        Circle()
            .fill(Color.white)
            .frame(width: 53, height: 53)
        Circle()
            .stroke(Color.white, lineWidth: 4)
            .frame(width: 63, height: 63)
    }
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 9, height: 9)
            //Layout select mode
            HStack {
                Button {
                    if singleMode == false {
                        singleMode = true
                    }
                } label: {
                    Text("Single Mode")
                        .font(.footnote)
                        .textCase(.uppercase)
                        .foregroundColor(singleMode ? Color.black : Color.gray)
                }
                .frame(width: 120)

                Spacer()
                Text(singleMode ? "Single Mode" : "Batch Mode")
                    .font(.footnote)
                    .textCase(.uppercase)
                    .foregroundColor(Color.white)
                Spacer()
                Button {
                    if singleMode == true {
                        singleMode = false
                    }
                } label: {
                    Text("Batch Mode")
                        .font(.footnote)
                        .textCase(.uppercase)
                        .foregroundColor(singleMode ? Color.gray : Color.black)
                }
                .frame(width: 120)
            }
            HStack {
                Button {
                    
                } label: {
                    Group {
                        if model.photo.count != 0 {
                            tempView
                        } else {
                            buttonGallery
                        }
                    }
                }
                .frame(width: 86, height: 58)
                .padding(.leading, 20.0)
                Spacer()
                Button {
                    self.onCapture()
                } label: {
                    buttonCapture
                }
                Spacer()
                Group {
                    if model.photo.count != 0 {
                        NavigationLink {
                            PreviewMainView(photo: $model.photo)
                        } label: {
                            HStack {
                                ZStack {
                                    Image(uiImage: model.photo[model.photo.endIndex - 1].image!)
                                        .resizable()
                                        .frame(width: 58, height: 58)
                                        .aspectRatio(contentMode: .fill)
                                        .animation(.spring())
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 28, height: 28)
                                    Text("\(model.photo.count)")
                                        .foregroundColor(Color.white)
                                }
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(.white)
                            }
                        }
                    } else {
                        tempView
                    }
                }
                .frame(width: 86, height: 58)
                .padding(.trailing, 20.0)
            }
            .padding(.top, 10.0)
            
            
        }
        .padding(.top, 5.0)
        .padding(.bottom, 20.0)
        .background(Color.black)
        
    }
}

struct CameraBottomControlView_Previews: PreviewProvider {
    static var previews: some View {
        CameraBottomControlView(model: CameraModel()){
            
        } onOpenGalery: {
            
        } onMoveNext: {
            
        }
    }
}
