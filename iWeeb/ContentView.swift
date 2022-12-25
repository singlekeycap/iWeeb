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
