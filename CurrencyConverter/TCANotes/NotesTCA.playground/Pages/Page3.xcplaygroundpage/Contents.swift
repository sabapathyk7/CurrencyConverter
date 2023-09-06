//: [Previous](@previous)

import SwiftUI
import Combine
var greeting = "Hello, playground"

//: [Next](@next)
/*
 Composition - In a rectangle

 Mutation
 SwiftUI - Build a Scalable App - https://www.pointfree.co/collections/composable-architecture/swiftui-and-state-management/ep65-swiftui-and-state-management-part-1
 Understanding the State of the application using the NavigationLink to move from one state to another state of application

    struct ContentView: View {
      var body: some View {
        EmptyView()
      }
    }
      returning EmptyView - Return keyword called implicitly - Acts as a computed property

    #State - @State var count: Int = 0
    self.$count
    #Binding - is a type when the value has been updated so that it can recompute the view with the latest information.
    State - local and non-persisted state

    #ObjectBinding - Concept in the SwiftUI provides @Binding
    Ability to mutate the state and the changes will be notified
    Having access to the responsibility - Single shared responsibility

    Conforming to protocol - ObservableObject
    single piece of data to be shared
    didChange - > Publishers -> Combine + SwiftUI
    Subscribers -> Subscribe the changes to the View
    Kind of Notification -> didChange method
    var didSet {
        didChange.send()
    }

 */

class AppState: ObservableObject {
  var count: Int = 0
  let objectDidChange = ObservableObjectPublisher()
}

struct ContentView: View {
  @State var count: Int = 0

  var body: some View {
    NavigationView {
      NavigationLink(destination: EmptyView()) {
        Text("Demo")
      }
    }
  }
}

import PlaygroundSupport

PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView(count: 0))
