//
//  ContentView.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 27/09/2023.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CameraScreenView()) {
                 Text("Camera")
                }
            }
            .navigationBarTitle("Files", displayMode: .inline)
            .navigationBarHidden(true)
        }
        
        .navigationBarItems(trailing: Button(action: {
            
        }, label: {
            Image(systemName: "squareshape.split.3x3")
                        .foregroundColor(Color.white)
        }))
        .navigationBarItems(trailing: Button(action: {
            
        }, label: {
            Image(systemName: "flashlight.on.fill")
                        .foregroundColor(Color.blue)
        }))
//        .accentColor(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
