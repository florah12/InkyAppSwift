//
//  UserProfile.swift
//  InkyApp
//
//  Created by Makhtar N'Diaye on 11/19/24.
//

import SwiftUI

struct UserProfile: View {
    let gradient = Gradient(colors: [.inkblue, .inkwhite])
    var body: some View {
            VStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        Image("demoprofilepic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .clipped()
                            .overlay(Circle().stroke(Color.white, lineWidth: 4 ))
                            .padding(.top, 52)
                        
                        Text("Estella Bella").font(.system(size: 20, weight: .semibold)).foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Text("@Its.Estella").font(.system(size: 18)).foregroundColor(.white)
                            .padding(.top, 2)
                        
                        Text("3").font(.system(size: 20, weight: .semibold)).foregroundColor(.white)
                            .padding(.top, 4)
                            .offset(x: -64, y: 10)
                        
                        Text("Creations").font(.system(size: 20)).foregroundColor(.white)
                            .offset(x: -64, y: 12)

                        Text("101.7k").font(.system(size: 20, weight: .semibold)).foregroundColor(.white)
                            .padding(.top, 4)
                            .offset(x: 64, y: -54)
                        
                        Text("Followers").font(.system(size: 20)).foregroundColor(.white)
                            .offset(x: 64, y: -52)

                    }
                    Spacer()
                }
                Spacer()
            }
        .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    UserProfile()
}
