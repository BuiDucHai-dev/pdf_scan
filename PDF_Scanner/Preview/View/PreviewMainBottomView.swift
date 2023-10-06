//
//  PreviewMainBottomView.swift
//  PDF_Scanner
//
//  Created by Bùi Đức Hải on 03/11/2023.
//

import SwiftUI

struct PreviewMainBottomView: View {
    
    @Binding var photo: [Photo]
    @Binding var currentItem: Int
    @Binding var action: PreviewMainView.PreviewMainAction
    @State var isDeleteAlertPresent = false
    
    var onDelete: () -> ()
    
    var body: some View {
        
        VStack(spacing: 0) {
            if (action == .enhance) {
                FilterSelectionView(photo: $photo, currentItem: $currentItem)
            }
            
            Divider()
            
            HStack {
                Group {
                    Button {
                        action = .enhance
                    } label: {
                        VStack {
                            Image(systemName: "wand.and.stars")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(getColorForIcon(selectedOption: .enhance))
                            Text("Enhance")
                                .font(.system(size: 11))
                                .fontWeight(.medium)
                                .foregroundColor(getColorForText(selectedOption: .enhance))
                        }
                    }
                }
                
                Group {
                    Spacer()
                    Button {
                        action = .next
                    } label: {
                        VStack {
                            Image(systemName: "crop")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(getColorForIcon(selectedOption: .next))
                            Text("Crop")
                                .font(.system(size: 11))
                                .fontWeight(.medium)
                                .foregroundColor(getColorForText(selectedOption: .enhance))
                        }
                    }
                }
                
                Group {
                    Spacer()
                    Button {
                        action = .next
                    } label: {
                        VStack {
                            Image(systemName: "text.viewfinder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(getColorForIcon(selectedOption: .next))
                            Text("Extract text")
                                .font(.system(size: 11))
                                .fontWeight(.medium)
                                .foregroundColor(getColorForText(selectedOption: .enhance))
                        }
                    }
                }
                
                Group {
                    Spacer()
                    Button {
                        action = .next
                    } label: {
                        VStack {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(getColorForIcon(selectedOption: .next))
                            Text("Rotate")
                                .font(.system(size: 11))
                                .fontWeight(.medium)
                                .foregroundColor(getColorForText(selectedOption: .enhance))
                        }
                    }
                }
                
                Group {
                    Spacer()
                    Button {
                        self.isDeleteAlertPresent.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(getColorForIcon(selectedOption: .next))
                            Text("Delete")
                                .font(.system(size: 11))
                                .fontWeight(.medium)
                                .foregroundColor(getColorForText(selectedOption: .enhance))
                        }
                    }
                    .alert(isPresented: $isDeleteAlertPresent) {
                        Alert(title: Text("Do you want to delete this photo?"),
                              message: Text("Message"),
                              primaryButton: .destructive(Text("Delete"), action: {onDelete()}),
                              secondaryButton: .default(Text("Cancel")))
                    }
                }
            }
            .padding(.all, 16)
        }
    }

    private func getColorForIcon(selectedOption: PreviewMainView.PreviewMainAction) -> Color {
        if self.action == .enhance {
            if selectedOption == .enhance {
                return Color.purple
            } else {
                return Color.blue
            }
        } else if action == .next {
            return Color.blue
        } else {
            return Color.gray
        }
    }
    
    private func getColorForText(selectedOption: PreviewMainView.PreviewMainAction) -> Color {
        if self.action == .not_determind {
            return Color.gray
        } else {
            return Color.secondary
        }
    }
}

struct PreviewMainBottomView_Previews: PreviewProvider {
    
    static var previews: some View {
        PreviewMainBottomView(photo: .constant([Photo(originalData: Data())]), currentItem: .constant(0), action: .constant(.enhance)) {
            
        }
    }
}
