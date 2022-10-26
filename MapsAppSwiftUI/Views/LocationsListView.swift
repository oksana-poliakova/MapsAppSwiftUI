//
//  LocationsListView.swift
//  MapsAppSwiftUI
//
//  Created by Oksana on 26.10.2022.
//

import SwiftUI

struct LocationsListView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: LocationsViewModel
    
    // MARK: - Init
    
    init(viewModel: StateObject<LocationsViewModel>) {
        self._viewModel = viewModel
    }
    
    // MARK: - Body
    
    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                Button {
                    viewModel.showNextLocation(location: location)
                } label: {
                    configureListRowView(location: location)
                }
                .padding(.vertical, 5)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView(viewModel: .init(wrappedValue: LocationsViewModel(locations: LocationsDataService.locations)))
    }
}

// MARK: - Extensions

extension LocationsListView {
    func configureListRowView(location: Location) -> some View  {
        HStack {
            if let imageName = location.imagesNames.first {
                 Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10 )
            }
            
            VStack(alignment: .leading ) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
