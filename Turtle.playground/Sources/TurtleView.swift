#if os(macOS)
import AppKit
public typealias PlatformView = NSView
public typealias PlatformColor = NSColor
public typealias PlatformPath = NSBezierPath
#endif
#if os(iOS)
import UIKit
public typealias PlatformView = UIView
public typealias PlatformColor = UIColor
public typealias PlatformPath = UIBezierPath
#endif


public class TurtleView: PlatformView {
	var turtle: Turtle
	var strokeColor: PlatformColor = PlatformColor.green {
		didSet {
			#if os(macOS)
			self.setNeedsDisplay(self.bounds)
			#endif
			#if os(iOS)
			self.setNeedsDisplay()
			#endif
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

	// For macOS.
	public override var isFlipped: Bool {
		true
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
		let path = PlatformPath()
		path.lineWidth = 3
		path.move(to: transalte(turtle.points[0], center: center))
		for point in turtle.points[1...] {
			#if os(macOS)
			path.line(to: transalte(point, center: center))
			#endif
			#if os(iOS)
			path.addLine(to: transalte(point, center: center))
			#endif
		}
		path.stroke()
	}
}
