//
//  PreviewMainView.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 03/10/2023.
//

import SwiftUI

struct PreviewMainView: View {
    
    @State var action: PreviewMainAction = PreviewMainAction.enhance
    @Binding var photo: [Photo]
    
    @State private var currentPage = 0
    @State private var cr = 0
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                VStack(spacing: 0) {
                    IAPBannerView {
                        
                    }
                    VStack {
                        VStack {
                            Text("Page \(currentPage + 1) of \(photo.count)")
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .foregroundColor(Color.black.opacity(0.6))
                                .background(Color.black.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                        }
                        .padding(.top, 35)
                        
                        Spacer()
                        
                        TabView(selection: $currentPage) {
                            ForEach(photo.indices, id: \.self) { index in
                                
//                                if let imageData = try? Data(contentsOf: getURL()), let uiImage = UIImage(data: imageData) {
//                                    Image(uiImage:uiImage)
////                                    Image("image_test")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .clipShape(RoundedRectangle(cornerRadius: 7))
//                                        .padding(.top, 12)
//                                        .padding(.bottom, 70)
//                                }
                                
                                if let image = photo[index].image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 7))
                                        .padding(.top, 12)
                                        .padding(.bottom, 70)
                                        .tag(index)
                                }
                            }
                        }
                        .onChange(of: currentPage) { newValue in
                            
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                    .frame(width: reader.self.size.width, height: reader.self.size.height * 0.8)
                    Spacer()
                }
                .background(Color.gray.opacity(0.25))
                .navigationTitle("Preview")
                .navigationBarItems(trailing: Button(action: {
                    
                }, label: {
                    Text("Save")
                        .foregroundColor(Color.blue)
                        .font(.body)
                        .fontWeight(.medium)
                }))
//                VStack {
//                    Spacer()
//                    PreviewMainBottomView(photo: $photo, currentItem: $cr, action: $action) {
//
//                    }
//                    .background(Color.white)
//                }
            }
        }
        .onChange(of: currentPage) { newValue in
            print("New value \(newValue)")
            cr = newValue
        }
    }
    
    private func getURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return  documentsDirectory.appendingPathComponent("hello.jpg")
        
    }
}

struct PreviewMainView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewMainView(photo: .constant([Photo(originalData: Data())]))
    }
}
