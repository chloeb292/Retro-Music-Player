//
//  Retro_MixtapeApp.swift
//  Retro Mixtape
//
//  Created by Chloe Berry on 10/22/22.
//

import SwiftUI
import Firebase

@main
struct Retro_MixtapeApp: App {
    let data = OurData()
    init(){
        FirebaseApp.configure()
        data.loadAlbums()
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    }
    var body: some Scene {
        WindowGroup {
            ContentView(data : data)
        }
    }
}
