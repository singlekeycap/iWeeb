//
//  CreditsTab.swift
//  iWeeb
//
//  Created by Dre Dall'Ara on 12/24/22.
//

import SwiftUI

struct CreditsTab: View {
    
    let credits : [String : String] = ["waifu.pics" : "https://waifu.pics", "nekos.best" : "https://nekos.best", "StackOverflow" : "https://stackoverflow.com", "SDWebImage" : "https://github.com/SDWebImage", "CyPwn" : "https://repo.cypwn.xyz", "Me" : "https://singlekeycap.ml"]
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            VStack() {
                Spacer()
                    .frame(height:15)
                VStack(){
                    ForEach(credits.sorted(by: <), id : \.key) { key, value in
                        HStack() {
                            Spacer()
                                .frame(width: 20)
                            Image(key)
                                .resizable(resizingMode: .stretch)
                                .frame(width: 40, height: 40)
                            Spacer()
                                .frame(width: 20)
                            Text(key)
                            Spacer()
                        }
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: value)!)
                        }
                        if key != "waifu.pics" {
                            Divider()
                        }
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
            Spacer()
                .frame(width: 20)
        }
    }
}
