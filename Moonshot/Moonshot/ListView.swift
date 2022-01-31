//
//  ListView.swift
//  Moonshot
//
//  Created by Tiago Mamouros on 31/01/2022.
//

import SwiftUI

struct ListView: View {
    
    let columns : [GridItem]
    let missions : [Mission]
    let astronauts : [String : Astronaut]
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(missions) { mission in
                    
                    NavigationLink {
                        
                        MissionView(mission: mission, astronauts: astronauts)
                        
                    } label: {
                        HStack{
                            Image(mission.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.title)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .opacity(0.9)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.lightBackground)
                            .foregroundColor(.white)

                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        }
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    
    static let columns = [
        GridItem(.adaptive(minimum: 150) )
    ]
    
    static let astronauts : [String : Astronaut] = Bundle.main.decode(file: "astronauts.json")
    static let missions : [Mission] = Bundle.main.decode(file: "missions.json")
    
    static var previews: some View {
        ListView(columns: columns, missions: missions, astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
