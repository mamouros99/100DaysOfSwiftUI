//
//  MissionView.swift
//  Moonshot
//
//  Created by Tiago Mamouros on 31/01/2022.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role : String
        let astronaut : Astronaut
    }
    
    
    let mission: Mission
    let crew : [CrewMember]

    
    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                VStack{
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6 )
                        .padding(.top)
                    
                    Text(mission.formattedLaunchDate)
                    
                    Rectangle()
                        .frame(height:2)
                        .foregroundColor(.lightBackground)
                        .padding(.vertical)
                    
                    VStack (alignment: .leading){
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        
                    }
                    .padding([.horizontal, .bottom])
                    
                    Rectangle()
                        .frame(height:2)
                        .foregroundColor(.lightBackground)
                        .padding(.vertical)
                    
                    VStack{
                        
                        Text("Crew")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title.bold())
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                ForEach(crew, id: \.role){ crewMember in
                                    NavigationLink {
                                        
                                        AstronautDetails(astronaut: crewMember.astronaut)
                                        
                                    } label: {
                                        HStack{
                                            Image(crewMember.astronaut.id)
                                                .resizable()
                                                .frame(width: 104, height: 72)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .overlay{
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .strokeBorder(crewMember.role == "Commander" ? .yellow : .white, lineWidth: 1)
                                                }
                                        }
                                        
                                        VStack(alignment: .leading){
                                            Text(crewMember.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            Text(crewMember.role)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .padding(.horizontal)

                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
            
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String : Astronaut]) {
        self.mission = mission
        crew = mission.crew.map{ member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }
            else {
                fatalError("\(member.name) not in data")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions : [Mission] = Bundle.main.decode(file: "missions.json")
    static let astronauts : [String : Astronaut] = Bundle.main.decode(file: "astronauts.json")
    
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
