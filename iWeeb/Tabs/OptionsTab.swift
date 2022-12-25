//
//  ContentTab.swift
//  iWeeb
//
//  Created by Dre Dall'Ara on 12/24/22.
//

import SwiftUI

struct OptionsTab: View {
    @Binding var endpoint : String
    @Binding var nsfw : Bool
    @Binding var provider : String
    let endpoints: [String : String] = ["Nekos" : "neko", "Waifus" : "waifu", "Shinobu" : "shinobu", "Megumin" : "megumin", "Bullying" : "bully", "Cuddling" : "cuddle", "Crying" : "cry", "Hugging" : "hug", "Wolf Girls" : "awoo", "Kissing" : "kiss", "Licks" : "lick", "Headpats" : "pat", "Smug" : "smug", "Bonk" : "bonk", "YEET" : "yeet", "Blushing" : "blush", "Smiling" : "smile", "Waving" : "wave", "High five" : "highfive", "Handholding" : "handhold", "Noms" : "nom", "Biting" : "bite", "Bear hug" : "glomp", "Slaps" : "slap", "Killing" : "kill", "Kicks" : "kick", "Happiness" : "happy", "Winking" : "wink", "Poking" : "poke", "Dancing" : "dance", "Cringy" : "cringe"]
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    HStack {
                        Spacer()
                        Text("Provider")
                        Spacer()
                    }
                    Picker("Provider: ", selection: $provider) {
                        Text("nekos.best").tag("nekos.best")
                        Text("waifu.pics").tag("waifu.pics")
                    }
                    .pickerStyle(.segmented)
                    if nsfw {
                        if provider == "nekos.best" {
                            Text("No NSFW endpoints available")
                        }
                        else {
                            Picker("Endpoint (NSFW): ", selection: $endpoint) {
                                Text("Nekos").tag("neko")
                                Text("Waifus").tag("waifu")
                                Text("Traps").tag("trap")
                                Text("Blowjobs").tag("blowjob")
                            }
                        }
                    } else {
                        if provider == "nekos.best" {
                            Picker("Endpoint: ", selection: $endpoint) {
                                Text("Nekos").tag("neko")
                                Text("Waifus").tag("waifu")
                                Text("Kitsunes").tag("kitsune")
                                Text("Husbandos").tag("husbando")
                            }
                        } else {
                            Picker("Endpoint: ", selection: $endpoint) {
                                ForEach(endpoints.sorted(by: <), id : \.key) { key, value in
                                    Text(key).tag(value)
                                }
                            }
                        }
                    }
                    Toggle(isOn: $nsfw) {
                        Text("NSFW:")
                    }
                }
            }
            Divider()
            Spacer()
                .frame(height:15)
        }
    }
}
