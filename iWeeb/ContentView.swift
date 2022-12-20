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

struct ContentView: View {
    @State var endpoint = "neko"
    @State var url = "https://nekos.best/api/v2/neko/0493.png"
    @State var saveImage = false
    @State var failed = false
    
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
            TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
                VStack() {
                    Spacer()
                    AsyncImage(url: URL(string: "\(url)")) {
                        image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                        .onTapGesture {
                            var request = URLRequest(url: URL(string: "https://nekos.best/api/v2/\(endpoint)")!)
                            request.httpMethod = "GET"
                            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                                let result = try! JSONDecoder().decode(BareBones.self, from: data!)
                                self.url = result.results[0].url
                            }
                            task.resume()
                        }
                        .onLongPressGesture {
                            self.saveImage = true
                        }
                        .alert("Save image?", isPresented: $saveImage) {
                            Button("Yes", role: .cancel) {
                                var request = URLRequest(url: URL(string: "\(url)")!)
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
                        Image(systemName: "heart.circle")
                        Text("Waifus")
                    }
                VStack(){
                    Spacer()
                        .frame(height:15)
                    HStack() {
                        Spacer()
                            .frame(width: 20)
                        Text("Endpoint: ")
                            .font(.body)
                        Picker(selection: $endpoint, label: Text("Endpoint")) {
                            Text("Nekos").tag("neko")
                            Text("Waifus").tag("waifu")
                            Text("Kitsunes").tag("kitsune")
                            Text("Husbandos").tag("husbando")
                        }
                        Spacer()
                    }
                    Spacer()
                    Divider()
                    Spacer()
                        .frame(height:15)
                }
                .tabItem {
                    Image(systemName: "gear.circle")
                    Text("Options")
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

                    }
                    Spacer()
                    Divider()
                    Spacer()
                        .frame(height:15)
                }
                    .tabItem {
                        Image(systemName: "text.aligncenter")
                        Text("Credits")
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
