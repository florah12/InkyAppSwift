//
//  UserProfile.swift
//  InkyApp
//
//  Created by Makhtar N'Diaye on 11/19/24.
//

import SwiftUI

struct UserProfile: View {
    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    Image("person.crop.circle")
                        .resizable()
                    .frame(width: 60, height: 60)
                    .overlay {
                            Circle()
                                .stroke(.gray.opacity(0.4),
                                        lineWidth: 2)
                                .frame(width: 90, height: 80)
                        }
                    Spacer()
                }
                .padding([.leading, .trailing])
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal){
                  
                }
            }
        }
    }
}

#Preview {
    UserProfile()
}
