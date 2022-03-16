//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Yaniv Hasbani on 12/03/2022.
//

import SwiftUI

fileprivate var minimumCardWidth = 60.0
struct AspectVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
  var items: [Item]
  var aspectRatio: CGFloat
  var content: (Item) -> ItemView
  
  
  
  init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder _ content: @escaping (Item) -> ItemView) {
    self.items = items
    self.aspectRatio = aspectRatio
    self.content = content
  }
  
  var body: some View {
    GeometryReader { geometry in
      let width = widthThatFits(geometry.size)
      if width >= minimumCardWidth {
        VStack {
          
          
          // In this case, it only gets the body content when the view is presented on screen
          LazyVGrid(columns: [self.gridItemWithNoSpace(width)], spacing: 0) {
            // ForEach needs the class that we iterate to conform to Identifiable
            // String does not.
            // In this case, we add the id and we say that the self is the identifiable, meaning the string itself
            // So what will happen is, if we have the same string twice, we will have 2 views but their @State will be the same!!!
            ForEach(items) { item in
              self.content(item)
                .aspectRatio(self.aspectRatio, contentMode: .fit)
            }
          }
          Spacer(minLength: 0)
        }
      } else {
        ScrollView {
          // Lazy refers to when the Grid actually gets the body var for each of the elements
          // In this case, it only gets the body content when the view is presented on screen
          LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumCardWidth))]) {
            // ForEach needs the class that we iterate to conform to Identifiable
            // String does not.
            // In this case, we add the id and we say that the self is the identifiable, meaning the string itself
            // So what will happen is, if we have the same string twice, we will have 2 views but their @State will be the same!!!
            ForEach(items) { item in
              self.content(item)
                .aspectRatio(self.aspectRatio, contentMode: .fit)
            }
          }
        }
      }
    }
  }
  
  private func gridItemWithNoSpace(_ width: CGFloat) -> GridItem {
    var gridItem = GridItem(.adaptive(minimum: width))
    gridItem.spacing = 0
    
    return gridItem
  }
  
  private func widthThatFits(_ size: CGSize) -> CGFloat {
    let numberOfElements = self.items.count
    
    var numberOfColumns = 1
    var numberOfRaws = numberOfElements
    
    repeat {
      let itemWidth = size.width / CGFloat(numberOfColumns)
      let itemHeight = itemWidth / self.aspectRatio
      
      if CGFloat(numberOfRaws) * itemHeight < size.height {
        break
      }
      
      numberOfColumns += 1
      numberOfRaws = (numberOfElements + numberOfColumns - 1) / numberOfColumns
    } while numberOfColumns < numberOfElements
    
    if numberOfColumns > numberOfElements {
      numberOfColumns = numberOfElements
    }
    
    return floor(size.width / CGFloat(numberOfColumns))
  }
}

//struct AspectVGrid_Previews: PreviewProvider {
//  static var previews: some View {
//    AspectVGrid()
//  }
//}
