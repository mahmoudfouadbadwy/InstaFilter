//
//  ContentView.swift
//  InstaFilter
//
//  Created by Mahmoud Fouad on 8/14/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var showingFilterActionSheet = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()

    private let context = CIContext()
    
   
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker.toggle()
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                    
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        self.showingFilterActionSheet.toggle()
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker,
                   onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterActionSheet) {
                ActionSheet(title: Text("Select a filter"),
                            buttons: [.default(Text("Crystallize"), action: {
                                self.setFilter(CIFilter.crystallize())
                            }),
                            .default(Text("Edges"), action: {
                                self.setFilter(CIFilter.edges())
                            }),
                            .default(Text("Gaussian Blur"), action: {
                                self.setFilter(CIFilter.gaussianBlur())
                            }),
                            .cancel()
                            ])
            }
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200 , forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10 , forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
        }
    }
    
    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
