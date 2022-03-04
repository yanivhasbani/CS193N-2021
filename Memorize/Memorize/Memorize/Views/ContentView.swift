//
//  ContentView.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 04/03/2022.
//

import SwiftUI

struct ContentView: View {
  let emojis = ["🚗", "🚛", "🚕", "✈️", "🛵",
                "🏍", "🛺", "🚃", "🚀", "🛸",
                "🚁", "🛶", "⛵️", "🚤", "🛥"]
  @State var currentlyDisplayingImjoiCounter = 15
  
  var body: some View {
    VStack {
      ScrollView {
        // Lazy refers to when the Grid actually gets the body var for each of the elements
        // In this case, it only gets the body content when the view is presented on screen
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
          // ForEach needs the class that we iterate to conform to Identifiable
          // String does not.
          // In this case, we add the id and we say that the self is the identifiable, meaning the string itself
          // So what will happen is, if we have the same string twice, we will have 2 views but their @State will be the same!!!
          ForEach(self.emojis[0..<self.currentlyDisplayingImjoiCounter],
                  id: \.self) {
            CardView(content:$0)
              .aspectRatio(2/3, contentMode: .fit)
          }
        }
      }
      
      HStack {
        self.addButton
        
        // A Spacer will grab as much space as it can!
        Spacer()
        
        Text("Shuffle")
          .foregroundColor(.blue)
        
        Spacer()
        
        self.removeButton
        
      }
      .font(.largeTitle)
    }
    .padding(.horizontal)
  }
  
  var removeButton: some View {
    Button {
      if self.currentlyDisplayingImjoiCounter > 1 {
        self.currentlyDisplayingImjoiCounter -= 1
      }
    } label: {
      Image(systemName: "minus.circle")
    }
  }
  
  var addButton: some View {
    Button {
      if self.currentlyDisplayingImjoiCounter < self.emojis.count {
        self.currentlyDisplayingImjoiCounter += 1
      }
    } label: {
      Image(systemName: "plus.circle")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.dark)
    ContentView()
      .preferredColorScheme(.light)
  }
}
