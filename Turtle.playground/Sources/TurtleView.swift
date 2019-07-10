import UIKit

public class TurtleView: UIView {
	var turtle: Turtle
	var strokeColor: UIColor = UIColor.green {
		didSet {
			self.setNeedsDisplay()
		}
	}
	public init(frame: CGRect, turtle: Turtle) {
		self.turtle = turtle
		super.init(frame: frame)
	}

	public convenience init(frame: CGRect, initialLocation:(Double, Double), @TurtleBuilder builder:()-> [Command]) {
		let turtle = Turtle(initialLocation, builder:builder)
		self.init(frame:frame, turtle: turtle )
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func draw(_ rect: CGRect) {

		func transalte(_ position:(Double, Double), center: CGPoint) -> CGPoint {
			let x = center.x + CGFloat(position.0)
			let y = center.y + (CGFloat(position.1) * -1)
			let point =  CGPoint(x: x, y: y)
			return point
		}

		super.draw(rect)
		if turtle.points.count < 2 {
			return
		}

		let center = CGPoint(x: self.bounds.width / 2, y:self.bounds.height / 2)
		strokeColor.setStroke()
		let path = UIBezierPath()
		path.lineWidth = 3
		path.move(to: transalte(turtle.points[0], center: center))
		for point in turtle.points[1...] {
			path.addLine(to: transalte(point, center: center))
		}
		path.stroke()
	}
}
