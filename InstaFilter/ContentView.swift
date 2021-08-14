//
//  ContentView.swift
//  InstaFilter
//
//  Created by Mahmoud Fouad on 8/14/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
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
                    
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: self.$filterIntensity)
                    
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
