#if os(macOS)
import AppKit
#endif

#if os(iOS)
import UIKit
#endif
import PlaygroundSupport
/*:

Lets' make a tutle!

You can use commands in the following list:

* `pass`: Do nothing.
* `turn`: Turn to a given angle.
* `forword`: Move forward and draw a line.
* `loop`: Repeat doing something.

*/

let v = TurtleView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), initialLocation: (50, 0)) {
	loop(9) {
		turn(140)
		forward(30)
		turn(-100)
		forward(30)
	}
	pass()
}

//let v = TurtleView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), initialLocation: (-150, 0)) {
//	left(45)
//	forward(30)
//	loop(10) {
//		right(90)
//		forward(30)
//		left(90)
//		forward(30)
//	}
//}

//let v = TurtleView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), initialLocation: (-150, 0)) {
//	left(90)
//	forward(30)
//
//	loop(5) {
//		right(90)
//		forward(10)
//		right(90)
//		forward(60)
//		left(90)
//		forward(10)
//		left(90)
//		forward(60)
//	}
//
//	right(90)
//	forward(10)
//	right(90)
//	forward(30)
//}

//v.backgroundColor = NSColor.white

PlaygroundPage.current.liveView = v
