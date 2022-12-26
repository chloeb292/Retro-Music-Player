//
//  PlayerView.swift
//  Retro Mixtape
//
//  Created by Chloe Berry on 10/22/22.
//

import Foundation
import SwiftUI
import Firebase
import AVFoundation

struct PlayerView : View {
    @State var album : Album
    @State var song : Song
    @State var player = AVPlayer()
    
    @State var isPlaying : Bool = false
    
    var body: some View {
        ZStack{
            Image(album.image).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .dark).edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                AlbumArt(album: album)
                Spacer()
                ZStack {
                    Color.black.cornerRadius(20).shadow(radius: 10).opacity(0.5).ignoresSafeArea(.all).frame(height: 250, alignment: .center)

                    Text(album.name).font(.headline).foregroundColor(.white).padding(.bottom, 150)
                    Text(song.name).font(.subheadline).foregroundColor(.white).padding(.bottom, 100)
                    HStack {
                        Button(action: self.previous, label: {
                            Image(systemName: "arrow.left.circle").resizable()
                        }).frame(width: 50, height: 50, alignment: .center).foregroundColor(Color.white)
                        
                        Button(action: self.playPause, label: {
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill").resizable().foregroundColor(Color(hue: 0.837, saturation: 0.466, brightness: 1.0).opacity(0.9))
                        }).frame(width: 50, height: 50, alignment: .center).padding()
                        
                        Button(action: self.next, label: {
                            Image(systemName: "arrow.right.circle").resizable()
                        }).frame(width: 50, height: 50, alignment: .center).foregroundColor(Color.white)
                            
                    }
                }
            }
        }.onAppear(){
            self.playSong()
        }
    }
    
    func playSong() {
        let storage = Storage.storage().reference(forURL: self.song.file)
        storage.downloadURL { (url, error) in
            if error != nil {
                print(error)
            }
            else {
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                }
                catch {
                    
                }
                player = AVPlayer(url: url!)
                player.play()
            }
        }
    }
    
    func playPause() {
        self.isPlaying.toggle()
        if isPlaying == false{
            player.pause()
        }
        else{
            player.play()
        }
    }
    
    func next() {
        if let currentIndex = album.songs.firstIndex(of: song) {
            if currentIndex == album.songs.count-1{
            }
            else{
                player.pause()
                song = album.songs[currentIndex + 1]}
            self.playSong()
            }
        }
    
    
    func previous() {
        if let currentIndex = album.songs.firstIndex(of: song) {
            if currentIndex == 0{
            }
            else{
                player.pause()
                song = album.songs[currentIndex - 1]}
                self.playSong()

            }
    }
}
