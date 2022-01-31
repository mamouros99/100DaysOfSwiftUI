//
//  ContentView.swift
//  Moonshot
//
//  Created by Tiago Mamouros on 30/01/2022.
//

import SwiftUI


struct ContentView: View {
    
    @State private var displayType = true
    
    let columns = [
        GridItem(.adaptive(minimum: 150) )
    ]
    
    let astronauts : [String : Astronaut] = Bundle.main.decode(file: "astronauts.json")
    let missions : [Mission] = Bundle.main.decode(file: "missions.json")
    
    var body: some View {
        NavigationView{
            
            Group{
                if(displayType){
                    GridView(columns: columns, missions: missions, astronauts: astronauts)
                }
                else{
                    ListView(columns: columns, missions: missions, astronauts: astronauts)
                }
                
            }
            .navigationTitle("MoonShot")
            .preferredColorScheme(.dark)
            .toolbar {
                Button{
                    displayType.toggle()
                } label: {
                    Image(systemName: !displayType ? "square.grid.2x2" : "list.dash")
                }
                .foregroundColor(.white)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
