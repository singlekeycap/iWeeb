//
//  ContentView.swift
//  iWeeb
//
//  Created by Dre Dall'Ara on 12/19/22.
//

import SwiftUI

struct BareBones: Decodable {
    let results: [Neko]
}

struct Neko: Decodable {
    let artist_href: String
    let artist_name: String
    let source_url: String
    let url: String
}

struct BareBonesNSFW: Decodable {
    let images: [NekoNSFW]
}

struct NekoNSFW: Decodable {
    let id: String
    let original_hash: String
    let uploader: String
    let approver: String
    let nsfw: Bool
    let artist: String
    let tags: [String]
    let comments: [String]
    let created_at: String
    let likes: Int
    let favorites: Int
}

struct ContentView: View {
    @State var endpoint = "neko"
    @State var url = URL(string: "https://nekos.best/api/v2/neko/0493.png")
    @State var saveImage = false
    @State var failed = false
    @State var nsfw = false
    @State var screen_width = UIScreen.main.bounds.width
    @State var screen_height = UIScreen.main.bounds.height
    
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
            Divider()
            Spacer()
            TabView {
                VStack() {
                    Spacer()
                    AsyncImage(url: url) {
                        image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                        .onTapGesture {
                            if self.nsfw {
                                let result = SION(jsonUrlString: "https://nekos.moe/api/v1/random/image?nsfw=true")
                                self.url = URL(string: "https://nekos.moe/image/\(result["images"][0]["id"].json.dropFirst().dropLast())")
                            }
                            else {
                                let result = SION(jsonUrlString: "https://nekos.best/api/v2/\(endpoint)")
                                self.url = URL(string: "\(result["results"][0]["url"].json.dropFirst().dropLast())")
                            }
                        }
                        .onLongPressGesture {
                            self.saveImage = true
                        }
                        .alert("Save image?", isPresented: $saveImage) {
                            Button("Yes", role: .cancel) {
                                var request = URLRequest(url: url!)
                                request.httpMethod = "GET"
                                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                                    let data = Data(data!)
                                    let image = UIImage(data: data)
                                    if image != nil {
                                        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                                    } else {
                                        self.failed = true
                                    }
                                }
                                task.resume()
                            }
                            Button("No", role: .destructive){
                                self.saveImage = false
                            }
                        }
                        .alert("Image saving failed", isPresented: $failed) {
                            Button("OK", role: .cancel) {
                                self.failed = false
                            }
                        }
                    Spacer()
                    Divider()
                    Spacer()
                        .frame(height:15)
                }
                    .tabItem {
                        Label("Waifus", systemImage: "heart.circle")
                    }
                VStack(){
                    Spacer()
                        .frame(height:15)
                    HStack() {
                        Spacer()
                            .frame(width: 20)
                        if self.nsfw {
                            Text("Endpoint (NSFW): ")
                                .font(.body)
                            Picker(selection: $endpoint, label: Text("Endpoint (NSFW)")) {
                                Text("Nekos").tag("neko")
                            }
                        } else {
                            Text("Endpoint: ")
                                .font(.body)
                            Picker(selection: $endpoint, label: Text("Endpoint")) {
                                Text("Nekos").tag("neko")
                                Text("Waifus").tag("waifu")
                                Text("Kitsunes").tag("kitsune")
                                Text("Husbandos").tag("husbando")
                            }
                        }
                        Spacer()
                    }
                    HStack() {
                        Spacer()
                            .frame(width: 20)
                        Toggle(isOn: $nsfw) {
                            Text("NSFW:")
                        }
                        .frame(width: screen_width/3)
                        Spacer()
                    }
                    Spacer()
                    Divider()
                    Spacer()
                        .frame(height:15)
                }
                .tabItem {
                    Label("Options", systemImage: "gear.circle")
                }
                VStack() {
                    Spacer()
                        .frame(height:15)
                    VStack(){
                        HStack() {
                            Spacer()
                                .frame(width: 20)
                            Image("nekos.best")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 40, height: 40)
                            Spacer()
                                .frame(width: 20)
                            Text("nekos.best")
                            Spacer()
                        }
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: "https://nekos.best")!)
                        }
                        Divider()
                        HStack() {
                            Spacer()
                                .frame(width: 20)
                            Image("StackOverflow")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 40, height: 40)
                            Spacer()
                                .frame(width: 20)
                            Text("StackOverflow")
                            Spacer()
                        }
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: "https://stackoverflow.com")!)
                        }
                        Divider()
                        HStack() {
                            Spacer()
                                .frame(width: 20)
                            Image("CyPwn")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 40, height: 40)
                            Spacer()
                                .frame(width: 20)
                            Text("CyPwn")
                            Spacer()
                        }
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: "https://repo.cypwn.xyz")!)
                        }
                        Divider()
                        HStack() {
                            Spacer()
                                .frame(width: 20)
                            Image("Keycap")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 40, height: 40)
                            Spacer()
                                .frame(width: 20)
                            Text("Me")
                            Spacer()
                        }
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: "https://singlekeycap.ml")!)
                        }
                        Spacer()
                        HStack() {
                            Spacer()
                                .frame(width: 20)
                            Image("GitHub")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 40, height: 40)
                            Spacer()
                                .frame(width: 20)
                            Text("Open sourced on GitHub!")
                            Spacer()
                        }
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: "https://github.com/singlekeycap/iWeeb")!)
                        }

                    }
                    Spacer()
                        .frame(height: 20)
                    Divider()
                    Spacer()
                        .frame(height: 15)
                }
                    .tabItem {
                        Label("Credits", systemImage: "newspaper.circle")
                    }
            }
        }
        .padding([.top, .leading, .trailing])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
