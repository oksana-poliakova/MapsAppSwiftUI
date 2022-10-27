//
//  LocationPreviewView.swift
//  MapsAppSwiftUI
//
//  Created by Oksana on 26.10.2022.
//

import SwiftUI

struct LocationPreviewView: View {
    
    // MARK: - Properties
    
    private let location: Location
    @StateObject private var viewModel: LocationsViewModel
    
    // MARK: - Init
    
    init(location: Location, viewModel: StateObject<LocationsViewModel>) {
        self.location = location
        self._viewModel = viewModel
    }
    
    // MARK: - Body
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            LocationPreviewView(location: LocationsDataService.locations.first!, viewModel: .init(wrappedValue: LocationsViewModel(locations: LocationsDataService.locations)))
                .padding( )
        }
    }
}

// MARK: - Extensions

extension LocationPreviewView {
   
    // Image section
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imagesNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(.white)
        .cornerRadius(10)
    }
    
    // Title section
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // Learn more button
    private var learnMoreButton: some View {
        Button {
            viewModel.sheetLocation = location 
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    // Next button
    private var nextButton: some View {
        Button {
            viewModel.nextButtonPressed() 
        } label: {
            Text("Next ")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
