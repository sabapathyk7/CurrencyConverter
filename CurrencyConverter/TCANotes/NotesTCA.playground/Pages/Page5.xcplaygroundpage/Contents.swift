//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
/*
 17th Aug

 State - Information required to operate and keep track of condition at a given moment in time

 Architecture - Set of rules, techniques, processes and patterns to develop a piece of software
 Scable and Testable

 UIKit - App State inconsistent   - Mutates independently of each other
 SwiftUI - State Rules Everything - Binding forces state sync across UI and Data
 UI = fn(State)
 State
 Shared State
 Shared Mutable State             - Uncontrolled - Mutation frm different sources
 Shared Global Mutable State      -

 Uncontrolled State - cause race conditions and unexpected states

 TCA solves this problem - single way to mutate state
      - Dispatching Action to the store that holds State
 Actions - only way to change the state
 Reducer - mutates from one state to another state
         - Current state to another state

 Side Effects - Asynchoronous work which result new action to update store
 Composable -

    Composition and Modurality
           - Modularity - difficult to resolve
           - built-in story to resolve
           - create smaller or mini modules or isolated module
           - Own test and dependency
           -

 struct - conforms to Reducer
 enum   - Equatable
 struct - Equatable
 reduce - mutate the state

 Pomodoro Example - How does the reducer helps in the Asynchronous calls
 Continuous Clock -

 @Dependency - Built in TCA
 Cancellable - Built-in feature that helps in cancelling the specific task and maintain the flow
 Important to avoid potential memory leaks



 */
