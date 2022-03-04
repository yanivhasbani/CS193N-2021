//
//  ContentView.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 04/03/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ZStack {
        RoundedRectangle(cornerRadius: 20)
          .stroke()
        Text("Hello World")
      }
      .padding(.all)
      .foregroundColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
