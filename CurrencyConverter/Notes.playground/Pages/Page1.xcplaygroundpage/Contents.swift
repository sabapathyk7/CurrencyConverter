import UIKit
import PlaygroundSupport

var greeting = "Hello, playground"

/*
 Notes, images, links and so on about TCA

 Founders of PointFree - Brendan William and Stephen Cellis
 TCA - The Composable Architecture

 Previous Architectures such as MVC, MVVM, VIPER, ELM, REDUX and so on.

 TCA - Opinionated
 Side Effect: Event modifies App State from outside - External Change - Debugging-tough
 State Management: Behaves for diff state value
 Composition: Divide and Conquer - well-defined, isolated
 Testing: Testing the mini modules
 Ergonomics - Framework Provides convenient APIs to implement the components

 State: Needed for logic and UI - Collection of properties
 Action: Enum of all possible actions - user actions, timer fires
 Reducer: Function - Evolve the current to next state, API requests and effect value
 Store: RunTime -> Sends all user actons to store - Run the reduce and effects -> Observe the change -> Update in the UI
 Environment is an optional - Dependencies
 Effect - Reduce returns some value to the Effect

 In UIKit - inconsitent with the UI State
     UIButton -*- ViewModel
 In SwiftUI - Consistent - State rules Everything
 */

let view = UIView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
view.backgroundColor = .white
let imageView = UIImageView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height))
view.addSubview(imageView)

if let sample = Bundle.main.path(forResource: "TCA_Basics", ofType: "png") {
  let image = UIImage(contentsOfFile: sample)
  imageView.image = image
}

PlaygroundPage.current.liveView = view
PlaygroundPage.current.liveView
