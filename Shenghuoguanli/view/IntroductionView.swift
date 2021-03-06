//
//  IntroductionView.swift
//  Shenghuoguanli
//
//  Created by 左启凡 on 2021/3/2.
//

import SwiftUI

struct IntroductionView: View {
    var body: some View {
        VStack{
            Text("一、对于持续性放松项目和持续性努力项目，点击开始时会记录当时的时刻，点击结束后就可计算出持续的分钟数，再乘以设置的比率就得出分数。\n\n二、对于一次性项目，批量按钮可以直接设置执行了几次，从而避免反复按一次按钮。\n\n三、对于可以用钱来衡量的一次性放松项目，建议把分数设为花费一元钱扣除的分数，放松后再在批量功能中输入花掉的钱。比如我添加一个“一般吃零食”项目，设置分数为30，之后我吃了一罐乐事薯片，买它花了8元钱，那么就点击批量，输入8，一共扣除240分。由于不提倡吃含糖量高的食品，可以再添加一个“吃高糖食品”项目，把分数设为70甚至更高，并且习惯以后再慢慢增加。")
            
            Spacer()
        }
        .padding()
        
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView()
    }
}
