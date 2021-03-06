//
//  NuliTitle.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/1.
//

import SwiftUI

struct NuliTitle: View {
    let allScore:String
    let todayScore:String
    
    var body: some View {
        VStack(spacing:screen.height*0.011){
            Text("").frame(height:screen.height*0.006)
            
            HStack{
                Text("总得分：")
                    .font(.system(size: screen.width*0.08))
                
                Text(allScore)
                    .font(.system(size: screen.width*0.08))
                
                Spacer()
            }
            HStack{
                Text("今天得分：")
                    .font(.system(size: screen.width*0.055))
                
                Text(todayScore)
                    .font(.system(size: screen.width*0.055))
                
                Spacer()
                
                Button(action: {
                    ContentView.dataStore.showEditScore=true
                }) {
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                            .opacity(0.7)
                        Text("修改")
                            .font(.system(size: screen.width/20))
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                    .frame(width:screen.width*0.16,height: screen.width*0.07)
                }
            }
        }
        .frame(width: screen.width*0.9)
    }
}

struct NuliTitle_Previews: PreviewProvider {
    static var previews: some View {
        NuliTitle(allScore: "9999", todayScore: "999")
    }
}
