//
//  IAPBannerView.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 04/10/2023.
//

import SwiftUI

struct IAPBannerView: View {
    
    var onGetPremium: () -> ()
    
    var body: some View {
        
        HStack {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 13, height: 10)
                        .scaledToFit()
                        .foregroundColor(Color.orange)
                    Text("Unlimited scan")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundColor(Color.primary)
                    Spacer()
                }
                HStack {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 13, height: 10)
                        .scaledToFit()
                        .foregroundColor(Color.orange)
                    Text("Unlock all professional tools")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundColor(Color.primary)
                    Spacer()
                }
            }
            
            Button {
                self.onGetPremium()
            } label: {
                Text("Get Premium")
                    .font(.body)
                    .fontWeight(.medium)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.orange)
                    .foregroundColor(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.7))
    }
}

struct IAPBannerView_Previews: PreviewProvider {
    static var previews: some View {
        IAPBannerView{
            
        }
    }
}
