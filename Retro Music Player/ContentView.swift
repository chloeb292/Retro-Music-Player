//
//  ContentView.swift
//  Retro Mixtape
//
//  Created by Chloe Berry on 10/22/22.
//

import SwiftUI
import UIKit
import Firebase


struct Album : Hashable {
    var id = UUID()
    var name : String
    var image : String
    var about : String
    var abtimg : String
    var songs : [Song]
}

struct Song : Hashable {
    var id = UUID()
    var name : String
    var time : String
    var file : String
}


struct ContentView: View {
    
        //Use this if NavigationBarTitle is with Large Font
//    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

//        //Use this if NavigationBarTitle is with displayMode = .inline
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
    
    @ObservedObject var data : OurData
    @State var currentAlbum : Album?
    
    var body: some View {
        
            NavigationView {
                
                // vertical
                ScrollView {
    //                Image("logo2").resizable().aspectRatio(contentMode: .fit)
                    // Albums
                    ScrollView (.horizontal, showsIndicators: false, content:{
                        // iterate through each album
                        LazyHStack{
                            ForEach(self.data.albums, id: \.self, content: {
                                album in
                                AlbumArt(album: album).onTapGesture{
                                    self.currentAlbum = album
                                }
                            })
                            
                        }
                        
                    })
                    
                    LazyVStack {
                        if self.data.albums.first == nil {
            
                        }
                        else
                        {
                            ForEach(self.currentAlbum?.songs ?? self.data.albums.first?.songs ?? [Song(name: "", time: "", file: "")], id: \.self, content: {song in
                            SongCell(album: currentAlbum ?? self.data.albums.first!, song: song)
                        })}
                        Text("About the Artist").foregroundColor(.white).font(.title).bold()
                        Text(self.currentAlbum?.name ?? "Journey").foregroundColor(Color(hue: 0.837, saturation: 0.466, brightness: 1.0)).font(.title).bold()
                        if(self.currentAlbum?.abtimg != nil){Image(self.currentAlbum?.abtimg ?? "journeyabt").resizable().cornerRadius(20).foregroundColor(.white).padding(10)
                            .frame(width: 350, height: 200)}
                        Text(self.currentAlbum?.about ?? "Journey is an American rock band formed in San Francisco in 1973 by former members of Santana, Steve Miller Band, and Frumious Bandersnatch.").foregroundColor(.white).font(.subheadline).padding()
                        

                    }
                
                
                }.foregroundColor(.white)
                    .background(.black)
                    .navigationTitle("Retro Music Player")
                    
                
                    
            }
                    
        
    }
}

struct AlbumArt : View {
    var album: Album
    var body: some View {
        ZStack(alignment: .bottom, content: {
            Image(album.image).resizable().frame(width: 200, height: 200, alignment: .center).cornerRadius(20)
//            ZStack {
//                Blur(style: .dark)
//                Text(album.name).font(.headline).foregroundColor(.white)
//            }.frame(width: 170, height: 60, alignment: .center)
        }).frame(width: 170, height: 200, alignment: .center).clipped().cornerRadius(20).padding(10).shadow(color: Color(hue: 0.837, saturation: 0.466, brightness: 1.0), radius: 10, x: 0, y: 0)
    }
}


struct SongCell : View {
    var album: Album
    var song: Song
    var body: some View {
        NavigationLink(
            destination: PlayerView(album: album, song: song),
        label:{
            HStack {
                Image("cassette").resizable().frame(width: 55, height: 35, alignment: .center).cornerRadius(5)
                Text(song.name).bold()
                Spacer()
                Text(song.time)
            }.padding(25)}).buttonStyle(PlainButtonStyle())
            
        }
}
