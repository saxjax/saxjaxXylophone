//
//  ContentView.swift
//  Shared
//
//  Created by Jakob Skov Søndergård on 15/06/2022.
//

import SwiftUI

struct ContentView: View {
    let vm = ContentViewModel()
    let toneNames:[ToneName] = [
        ToneName(toneName: "C", color:.green),
        ToneName(toneName:"D",color:.yellow),
        ToneName(toneName:"E",color:.gray),
        ToneName(toneName:"F",color:.cyan),
        ToneName(toneName:"G",color:.indigo),
        ToneName(toneName:"A",color:.mint),
        ToneName(toneName:"B",color:.blue)]
    @State var clicked = false
    var clickedOpacity = 0.2

    var body: some View {
        VStack {
            Text("Xylophone").font(.largeTitle).fontWeight(.heavy)
            ForEach(toneNames, id: \.self){element in
                ExtractedView(clicked: clicked, clickedOpacity: clickedOpacity,callback:vm.playSound, element: element)

            }.frame(maxWidth: .infinity, alignment: .center)
                .background(Color.red)


        }
    }

}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}


struct ExtractedView: View {
    @State var clicked = false
    @State var clickedOpacity: Double
    var callback : (String?)->()
    let element:ToneName
    var body: some View {
        Button(
            action:{
                clicked = true
                self.callback(element.toneName)

                var runCount = 0
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    print("Timer fired!")
                    runCount += 1
                    if runCount == 3 {
                        timer.invalidate()
                        clicked = false
                    }
                }


            }
        )
        {
            Label(
                title:{
                    Text(element.toneName)
                },
                icon: {
                    Image(systemName: "trash")
                }
            )
            .padding().foregroundColor(.black)
            .frame(minWidth:0, maxWidth: .infinity)
            .scaledToFill()
            .background(element.color)
            .opacity(clicked ?clickedOpacity :1)

        }
    }


}

struct ToneName:Hashable{
    var toneName: String
    var color: Color
}
