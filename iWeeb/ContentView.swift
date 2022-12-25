//
//  ContentView.swift
//  iWeeb
//
//  Created by Dre Dall'Ara on 12/19/22.
//

import SwiftUI

struct ContentView: View {
    @State var endpoint = "neko" as String
    @State var url = URL(string: "https://media.tenor.com/ruxAFVJ03ogAAAAd/cat-berg-cat.gif")
    @State var saveImage = false
    @State var failed = false
    @State var nsfw = false
    @State var provider = "nekos.best"
    @State var imageData = Data(stringLiteral: "")
    let endpoints: [String : String] = ["Nekos" : "neko", "Waifus" : "waifu", "Shinobu" : "shinobu", "Megumin" : "megumin", "Bullying" : "bully", "Cuddling" : "cuddle", "Crying" : "cry", "Hugging" : "hug", "Wolf Girls" : "awoo", "Kissing" : "kiss", "Licks" : "lick", "Headpats" : "pat", "Smug" : "smug", "Bonk" : "bonk", "YEET" : "yeet", "Blushing" : "blush", "Smiling" : "smile", "Waving" : "wave", "High five" : "highfive", "Handholding" : "handhold", "Noms" : "nom", "Biting" : "bite", "Bear hug" : "glomp", "Slaps" : "slap", "Killing" : "kill", "Kicks" : "kick", "Happiness" : "happy", "Winking" : "wink", "Poking" : "poke", "Dancing" : "dance", "Cringy" : "cringe"]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Text("iWeeb")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text("With ❤️ by\nSingleKeycap#2107")
                    .font(.caption)
                    .multilineTextAlignment(.trailing)
            }
            .padding([.leading,.trailing,.top])
            Divider()
            Spacer()
            TabView {
                ImageTab(endpoint: $endpoint, url: $url, saveImage: $saveImage, failed: $failed, nsfw: $nsfw, provider: $provider, imageData: $imageData)
                    .onTapGesture {
                        if #available(iOS 14, *){
                            for trans in endpoints {
                                if trans.key == endpoint {
                                    endpoint = trans.value
                                }
                            }
                        }
                        if self.nsfw {
                            if provider == "waifu.pics" {
                                let result = SION(jsonUrlString: "https://api.waifu.pics/nsfw/\(endpoint)")
                                url = URL(string: "\(result["url"].json.dropFirst().dropLast())")
                            }
                        }
                        else {
                            if provider == "waifu.pics" {
                                let result = SION(jsonUrlString: "https://api.waifu.pics/sfw/\(endpoint)")
                                url = URL(string: "\(result["url"].json.dropFirst().dropLast())")
                            }
                            else {
                                let result = SION(jsonUrlString: "https://nekos.best/api/v2/\(endpoint)")
                                url = URL(string: "\(result["results"][0]["url"].json.dropFirst().dropLast())")
                            }
                        }
                    }
                    .tabItem {
                        Label("Waifus", systemImage: "heart")
                    }
                OptionsTab(endpoint: $endpoint, nsfw: $nsfw, provider: $provider)
                    .tabItem {
                        Label("Options", systemImage: "gear")
                    }
                CreditsTab()
                    .tabItem {
                        Label("Credits", systemImage: "newspaper")
                    }
            }
        }
    }
}
