//
//  AstronautDetails.swift
//  Moonshot
//
//  Created by Tiago Mamouros on 31/01/2022.
//

import SwiftUI

struct AstronautDetails: View {
    
    let astronaut : Astronaut
    
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
            
            
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautDetails_Previews: PreviewProvider {
    
    static let astronauts : [String : Astronaut] = Bundle.main.decode(file: "astronauts.json")
    
    static var previews: some View {
        AstronautDetails(astronaut: astronauts["armstrong"]! )
            .preferredColorScheme(.dark)
    }
}
