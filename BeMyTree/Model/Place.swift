//
//  Place.swift
//  TreeForYourKid
//
//  Created by vladimir.kuzomenskyi on 21.02.2025.
//

import SwiftUI
import Combine

struct Place: Identifiable {
    let id: String = UUID().uuidString
    let image: Image
    let title: String
    let description: String
    let addressString: String
    let distanceString: String
    
    var isFavourite = false
    
    static let rockefeller: Place = .init(image: Image("rockefeller"), title: "Rockefeller State Park Preserve", description: "Rockefeller State Park Preserve in Westchester County, New York, spans 1,400 acres with scenic trails, woodlands, meadows, and the Pocantico River. Ideal for hiking, horseback riding, and birdwatching, it offers peaceful natural beauty and historic stone walls.", addressString: "125 Phelps Way, Pleasantville, NY 10570", distanceString: "9,7 m")
//    static let prospectPark: Place = .init(image: Image("prospekt-park"), title: "Prospect park", description: "Prospect Park is a 526-acre urban oasis in Brooklyn, New York, featuring lush landscapes, a lake, trails, sports facilities, and the Prospect Park Zoo. Designed by Olmsted and Vaux, it offers a serene escape with recreational and cultural activities for all.", addressString: "Coney Island Ave/Church Av, Parkside Ave, Brooklyn, NY 11218")
    static let fireIsland: Place = .init(image: Image("Fire Island National Seashore"), title: "Fire Island National Seashore", description: "Fire Island National Seashore is a 26-mile barrier island off Long Island, New York, known for its pristine beaches, dunes, maritime forests, and diverse wildlife. It offers recreational activities like swimming, hiking, and birdwatching, along with historic landmarks like the Fire Island Lighthouse. The area is car-free, providing a tranquil escape.", addressString: "Fire Island, NY", distanceString: "2,6 m")
    
    static let marine: Place = .init(image: Image("marine"), title: "Marine Park Salt Marsh Nature Trail", description: "The Marine Park Salt Marsh Nature Trail in Brooklyn, New York, is a serene 1.5-mile loop through a protected salt marsh ecosystem. It offers scenic views, birdwatching opportunities, and a chance to explore coastal habitats with interpretive signs along the way.", addressString: "Marine Park Salt Marsh Nature Center, 3301 Avenue U, Brooklyn, NY 11234", distanceString: "5,1 m")
}
