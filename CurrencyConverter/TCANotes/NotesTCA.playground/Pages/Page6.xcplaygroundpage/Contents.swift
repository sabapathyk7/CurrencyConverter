//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

/*

 ObservableObject -
 Protocol utilizes an objectWillChange property of ObservableObjectPublisher
 - pinged before any mutations are made to the model
 - willSet will be used

 ObservableObjectPublisher - synthesized automatically
 properties wrapped with Published - automatically be subscribed to the SwiftUI

 State Management isn't Composable

 SwiftUI isn't testable

 Shared state amongst many views
 where to allow mutations
 opinionated -

 onDelete


 Problem 1 - Mutations just littered throughout our views
           - obscuring how data feeds to the system
   lot of indirection

 Breakdown these views to smaller amounts
 - No need to take from AppState


 ObservableObject - bit nicer than the BindableObject

 Synthesize the publisher for us automatically

 Value types are great containers for the State - fine grains of control and guarantees of immutability
 Convert AppState to be a struct

 Store<Value> will be more reusable

 Decoupled the state from the Combine and SwiftUI frameworks

 Store responsibility to run a reducer


 inout -> Void

 (A) -> A
 inout A -> Void

 (A,B) -> (A,C)
 inout (A,B) -> C

 (Value, Action) -> Value
 (inout Value, Action) -> Void


 State Pullbacks

 -> Modified the Model to Struct
 -> Store becomes more responsible kind of mutable version

 Composable properties of reducer functions

 Functions are composable
 the signature of the reducer functions -> supports a bunch of different types of compositions
 breaking the reducers into smaller modules
 Composition

 Reducer PullBacks

 Snapshot strategy
 Snapshoting UI images - pull back to CA Layers - pull that back to work on UI views - pull back to UIViewControllers
State PullBack

 WritableKeyPath<globalstate, localstate>
 \.count ->  Key value path
 \.self - App stick to App State where the getter returns self
 snapshot strategy


 Action PullBack
enums have no concept of keypaths
 Keypath have two key components
  - getter and setter

 swift run generate-enum-properties

 generate enum properties using the composable



 anchor tap - optional anchor
 AppAction.counter
 WritableKeyPath<AppAction, CounterAction?>

 Keypaths on enums would give us the ability to pullback actions

 Third form of pullback

 Pulled back all small module functions - Actions
 higher order Randomness

 Higher Order Reducer 

 */
