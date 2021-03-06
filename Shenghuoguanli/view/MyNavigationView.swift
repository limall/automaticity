//
//  MyNavigationView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/1.
//

import SwiftUI

struct MyNavigationView: View {
    @Binding var showNuli:Bool
    @Binding var showFangsong:Bool
    @Binding var showSetting:Bool
    
    @ObservedObject var store:DataStore
    
    var body: some View {
        ZStack{
            ZStack{
                Rectangle()
                    .foregroundColor(store.isDark ? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)) : Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                    .frame(width:screen.width,height: screen.height*0.09)
                
                HStack(spacing:screen.width/6){
                    ZStack{
                        Rectangle()
                            .foregroundColor(store.isDark ? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)) : Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .opacity(0.7)
                        Text("努力")
                            .font(.system(size: screen.width/17))
                            .foregroundColor(showNuli ? Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)):Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                    .frame(width:screen.width*0.165,height: screen.width*0.085)
                    .onTapGesture {
                        showNuli=true
                        showFangsong=false
                        showSetting=false
                    }
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(store.isDark ? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)) : Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .opacity(0.7)
                        Text("放松")
                            .font(.system(size: screen.width/17))
                            .foregroundColor(showFangsong ? Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)):Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                    .frame(width:screen.width*0.165,height: screen.width*0.085)
                    .onTapGesture {
                        showFangsong=true
                        showNuli=false
                        showSetting=false
                    }
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(store.isDark ? Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)) : Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .opacity(0.7)
                        Text("设置")
                            .font(.system(size: screen.width/17))
                            .foregroundColor(showSetting ? Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)):Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                    .frame(width:screen.width*0.165,height: screen.width*0.085)
                    .onTapGesture {
                        showSetting=true
                        showNuli=false
                        showFangsong=false
                    }
                }
                .offset(y:-screen.height*0.008)
            }
            .offset(y:screen.height*0.45)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MyNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MyNavigationView(showNuli: .constant(true), showFangsong: .constant(false), showSetting: .constant(false),store: DataStore())
    }
}
