//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by CS193p Instructor on 4/26/21.
//  Copyright © 2021 Stanford University. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
  @ObservedObject var document: EmojiArtDocument
  @State private var selectedEmojies: Set<Emoji> = []
  
  var mutatableEmojies: [Emoji] {
    print("Selected is empty =  \(self.selectedEmojies.isEmpty)")
    return self.selectedEmojies.isEmpty ? self.document.emojis : Array(self.selectedEmojies)
  }
  
  var body: some View {
    VStack(spacing: 0) {
      ZStack(alignment: .topLeading) {
        documentBody
        deleteEmojiesButton
          .padding(.all)
          .transition(.opacity)
      }
      palette
    }
  }
  
  @ViewBuilder
  private var deleteEmojiesButton: some View {
    if !self.selectedEmojies.isEmpty {
      Button {
        withAnimation {
          for emoji in self.selectedEmojies {
            withAnimation {
              self.document.removeEmoji(emoji)
            }
          }
          
          self.selectedEmojies.removeAll()
        }
      } label: {
        Label("Delete all selected emojies", systemImage: "trash")
          .font(.title.bold())
          .foregroundColor(.white)
          .padding(20)
          .background(RoundedRectangle(cornerRadius: 25))
          .foregroundColor(.red)
      }
    }
  }
  
  var documentBody: some View {
    GeometryReader { geometry in
      ZStack {
        Color.white.overlay (
          OptionalImage(uiImage: document.backgroundImage)
            .scaleEffect(zoomScale)
            .position(self.convertFromEmojiCoordinates((0,0),
                                                       in: geometry))
        )
        .gesture(
          self.doubleTapToZoom(in: geometry.size)
            .exclusively(before: self.tapToDeselect())
        )
        
        if self.document.backgroundImageFetchStatus == .fetching {
          ProgressView().scaleEffect(2)
        } else {
          ForEach(self.document.emojis) { emoji in
            Text(emoji.text)
              .selected(self.selectedEmoji(emoji))
              .font(.system(size: CGFloat(emoji.size)))
              .scaleEffect(self.scale(for: emoji))
              .scaleEffect(self.zoomScale)
              .position(self.position(for: emoji, in: geometry))
              .offset(self.selectedEmojies.contains(where: {$0.id == emoji.id}) ? self.emojiPanOffset : .zero)
              .onTapGesture {
                self.selectedEmojies.toggleMembership(of: emoji)
              }
              .gesture(self.panGesture(emoji))
          }
        }
      }
      .clipped()
      .onDrop(of: [.plainText,.url,.image],
              isTargeted: nil) { providers, location in
        self.drop(providers: providers, at: location, in: geometry)
      }
      .gesture(panGesture().simultaneously(with: zoomGesture()))
    }
  }
  
  private func selectedEmoji(_ emoji: Emoji) -> Bool {
    return self.selectedEmojies.contains(where: {$0.id == emoji.id})
  }
  
  // MARK: - Drag and Drop
  private func drop(providers: [NSItemProvider],
                    at location: CGPoint,
                    in geometry: GeometryProxy) -> Bool {
    var found = providers.loadObjects(ofType: URL.self) { url in
      self.document.setBackground(.url(url.imageURL))
    }
    
    if !found {
      found = providers.loadObjects(ofType: UIImage.self) { image in
        if let data = image.jpegData(compressionQuality: 1.0) {
          self.document.setBackground(.imageData(data))
        }
      }
    }
    if !found {
      found = providers.loadObjects(ofType: String.self) { string in
        if let emoji = string.first, emoji.isEmoji {
          self.document.addEmoji(String(emoji),
                                 at: self.convertToEmojiCoordinates(location, in: geometry))
        }
      }
    }
    
    return found
  }
  
  // MARK: - Positioning/Sizing Emoji
  
  private func position(for emoji: Emoji,
                        in geometry: GeometryProxy) -> CGPoint {
    self.convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry)
  }
  
  private func convertToEmojiCoordinates(_ location: CGPoint,
                                         in geometry: GeometryProxy) -> (x: Int, y: Int) {
    let center = geometry.frame(in: .local).center
    let location = CGPoint(
      x: (location.x - self.panOffset.width - center.x) / self.zoomScale,
      y: (location.y - self.panOffset.height - center.y) / self.zoomScale
    )
    return (Int(location.x), Int(location.y))
  }
  
  private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int),
                                           in geometry: GeometryProxy) -> CGPoint {
    let center = geometry.frame(in: .local).center
    return CGPoint(
      x: center.x + CGFloat(location.x) * self.zoomScale + self.panOffset.width,
      y: center.y + CGFloat(location.y) * self.zoomScale + self.panOffset.height
    )
  }
  
  
  // MARK: Selection
  private func tapToDeselect() -> some Gesture {
    TapGesture(count: 1)
      .onEnded {
        self.selectedEmojies.removeAll()
      }
  }
  
  // MARK: - Zooming
  @State private var steadyStateZoomScale: CGFloat = 1
  @GestureState private var gestureZoomScale: CGFloat = 1
  @GestureState private var emojiZoomOffset: CGFloat = 1
  
  private var zoomScale: CGFloat {
    self.steadyStateZoomScale * self.gestureZoomScale
  }
  
  private func scale(for emoji: Emoji) -> CGFloat {
    selectedEmojies.contains(where: {$0.id == emoji.id}) ? self.zoomScale * self.emojiZoomOffset : self.zoomScale
  }
  
  private func zoomGesture() -> some Gesture {
    if self.selectedEmojies.count != 0 {
      return MagnificationGesture()
        .updating($emojiZoomOffset) { latestGestureScale, emojiZoomOffset, _ in
          emojiZoomOffset = latestGestureScale
        }
        .onEnded { gestureScaleAtEnd in
          self.document.scaleEmojies(self.mutatableEmojies,
                                     by: gestureScaleAtEnd)
        }
    } else {
      return MagnificationGesture()
        .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, _ in
          gestureZoomScale = latestGestureScale
        }
        .onEnded { gestureScaleAtEnd in
          self.steadyStateZoomScale *= gestureScaleAtEnd
        }
    }
  }
  
  private func doubleTapToZoom(in size: CGSize) -> some Gesture {
    TapGesture(count: 2)
      .onEnded {
        withAnimation {
          self.zoomToFit(self.document.backgroundImage, in: size)
        }
      }
  }
  
  private func zoomToFit(_ image: UIImage?, in size: CGSize) {
    if let image = image, image.size.width > 0,
       image.size.height > 0, size.width > 0, size.height > 0  {
      let hZoom = size.width / image.size.width
      let vZoom = size.height / image.size.height
      
      self.steadyStatePanOffset = .zero
      self.steadyStateZoomScale = min(hZoom, vZoom)
    }
  }
  
  // MARK: - Panning
  @State private var steadyStatePanOffset = CGSize.zero
  @GestureState private var gesturePanOffset = CGSize.zero
  @GestureState private var emojiPanOffset = CGSize.zero
  
  private var panOffset: CGSize {
    (self.steadyStatePanOffset + self.gesturePanOffset) * self.zoomScale
  }
  
  private func panGesture(_ emoji: Emoji? = nil) -> some Gesture {
    if let emoji = emoji, selectedEmojies.contains(where: {$0.id == emoji.id}) {
      return DragGesture()
        .updating($emojiPanOffset) { latestDragGestureValue, emojiPanOffset, _ in
          emojiPanOffset = latestDragGestureValue.translation
        }
        .onEnded { finalDragGestureValue in
          self.document.moveEmojies(self.mutatableEmojies,
                                    by: finalDragGestureValue.translation / self.zoomScale)
        }
    } else {
      if self.selectedEmojies.count == 0 {
        return DragGesture()
          .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, _ in
            gesturePanOffset = latestDragGestureValue.translation / self.zoomScale
          }
          .onEnded { finalDragGestureValue in
            self.steadyStatePanOffset = self.steadyStatePanOffset + (
              finalDragGestureValue.translation / self.zoomScale
            )
          }
      } else {
        return DragGesture()
          .updating($emojiPanOffset) { latestDragGestureValue, emojiPanOffset, _ in
            emojiPanOffset = latestDragGestureValue.translation
          }
          .onEnded { finalDragGestureValue in
            self.document.moveEmojies(self.mutatableEmojies,
                                      by: finalDragGestureValue.translation / self.zoomScale)
          }
      }
    }
  }
  
  // MARK: - Palette
  
  var palette: some View {
    ScrollingEmojisView(emojis:
                          self.document.emojisText
    )
      .font(.system(size: CGFloat(Emoji.Constant.defaultFontSize)))
  }
}

struct ScrollingEmojisView: View {
  let emojis: String
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack {
        ForEach(emojis.map { String($0) }, id: \.self) { emoji in
          Text(emoji)
            .onDrag { NSItemProvider(object: emoji as NSString) }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiArtDocumentView(document: EmojiArtDocument())
  }
}
