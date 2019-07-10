import UIKit
import PlaygroundSupport

let v = TurtleView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), initialLocation: (50, 0)) {

	loop(9) {
		turn(140)
		move(30)
		turn(-100)
		move(30)
	}
	pass()
}

v.backgroundColor = UIColor.white

PlaygroundPage.current.liveView = v
