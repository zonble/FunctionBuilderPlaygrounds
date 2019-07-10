import UIKit
import PlaygroundSupport

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

v.backgroundColor = UIColor.white

PlaygroundPage.current.liveView = v
