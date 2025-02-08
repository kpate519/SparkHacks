//////
//////  ContentView.swift
//////  Everday 2.0
//////
//////  Created by Nour Alsramah on 2/7/25.
//////
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var fountains: [Fountain] = []
    @State private var selectedFountain: Fountain?
  
    @State private var showingPopup = false
    @State private var showMap = false // State to control map visibility
    @State private var showIntroPage = true // State to control the intro page visibility
    @State private var showSecPage = false// State to control the intro page visibility

    private func loadFountains() {
        guard let url = Bundle.main.url(forResource: "fountains", withExtension: "json") else {
            print("Failed to locate fountains.json in bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            fountains = try decoder.decode([Fountain].self, from: data)
        } catch {
            print("Error loading JSON: \(error.localizedDescription)")
        }
    }

    var body: some View {
        ZStack {
            if showIntroPage {
                IntroPageView(showIntroPage: $showIntroPage, showSecPage: $showSecPage)
                
            } else if showSecPage {
                SecondPageView(showSecPage: $showSecPage, showIntroPage: $showIntroPage)
            } else {
                // Show map after intro page is dismissed
                Map {
                    
                    ForEach(fountains) { fountain in
                        Annotation(fountain.building, coordinate: fountain.coordinate) {
                            VStack {
                                Image(systemName: "drop.fill") // Water Drop Icon
                                    .font(.title)
                                    .frame(width: 15, height: 20)
                                    .foregroundColor(.white)
                                    .padding(15)
                                    .background(Circle().fill(Color.cyan.opacity(0.8)))
                            }
                            .onTapGesture {
                                selectedFountain = fountain
                            }
                        }
                    }
                }
//                .frame(width: 500,height: 500)
                .onAppear {
                    loadFountains()
                }
//                .background(
//                    Image(uiImage: UIImage(named: "Frame 4.jpg")!) // Replace with your image name
//                        .resizable()
////                        .scaledToFill()
//                    
//                        .edgesIgnoringSafeArea(.all) // Ensures the image fills the entire background
//                )
                .sheet(item: $selectedFountain) { fountain in
                    FountainDetailView(fountain: fountain)
                        .frame(width: 300, height: 300) // Square size
                        .background(Color.cyan.opacity(0.2)) // Opaque background for the pop-up only
                        .cornerRadius(20) // Rounded corners
                        .shadow(radius: 10) // Floating effect
                }
                .transition(.slide) // Slide transition when the map is shown
            }
        }
    }
}

struct IntroPageView: View {
    @Binding var showIntroPage: Bool
    @Binding var showSecPage: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Image inserted here
                Image(uiImage: UIImage(named: "image 1.jpg")!) // Replace with your image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
    
                
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showIntroPage = false // Transition to map on button click
                                showSecPage = true
                            }
                        }) {
                            Text("")
                                .frame(width: 100, height: 50)
                                .font(.title)
                                .padding()
                                .background(Color.clear)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 10) // Shadow to make the button stand out
                        }
                        .padding(.bottom, 40)
                    }
                    .frame(maxWidth: .infinity) // This ensures the HStack takes up the full width
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom) // Ensures the button stays at the bottom
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .transition(.opacity) // Fade transition for the intro page
    }
}

struct FountainDetailView: View {
    let fountain: Fountain
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 20) {
            Text(fountain.building)
                .font(.body)
                .multilineTextAlignment(.center)
                .bold()
            Text("\(fountain.location)")
            Button("Close") {
                dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
struct SecondPageView: View {
    @Binding var showSecPage: Bool
    @Binding var showIntroPage: Bool
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Image inserted here
                Image(uiImage: UIImage(named: "Frame 2.jpg")!) // Replace with your image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
    
                
                VStack {

                    HStack{
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showSecPage = false // Transition to map on button click
                            }
                        }) {
                            Text("")
                                .frame(width: 200, height: 25)
                                .font(.title)
                                .padding()
                                .background(Color.clear)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 10) // Shadow to make the button stand out
                        }
                        .padding(.trailing, 100)
                        .padding(.top, 120)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity) // This ensures the HStack takes up the full width
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .transition(.opacity) // Fade transition for the intro page
    }
}



#Preview {
    ContentView()
}
