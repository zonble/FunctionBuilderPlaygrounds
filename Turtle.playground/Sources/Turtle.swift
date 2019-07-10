import Foundation

public enum Command {
	case turn(Int)
	case forward(Int)
	case loop(UInt, [Command])
	case pass
}

/// Turn to the given angle.
/// - Parameter angle: The angle.
public func turn(_ angle:Int) -> Command {
	return .turn(angle)
}

/// Turn left to the given angle.
/// - Parameter angle: The angle.
public func left(_ angle:Int) -> Command {
	return .turn(angle)
}

/// Turn right to the given angle.
/// - Parameter angle: The angle.
public func right(_ angle:Int) -> Command {
	return .turn(angle * -1)
}

/// Move forward.
/// - Parameter length: How long do we move.
public func forward(_ length:Int) -> Command {
	return .forward(length)
}

/// Run a loop.
/// - Parameter repeatCount: How many times do we repeat.
/// - Parameter builder: The commands to run.
public func loop(_ repeatCount: UInt, @TurtleBuilder builder:()-> [Command]) -> Command {
	return .loop(repeatCount, builder())
}

/// Pass.
public func pass()-> Command {
	return .pass
}

@_functionBuilder
public struct TurtleBuilder {
	public static func buildBlock(_ command:Command, _ commands:Command...) -> [Command] {
		return [command] + commands
	}
}

public class Turtle {
	private var initialLocation: (Double, Double)
	private var commands:[Command]

	public init(_ initialLocation: (Double, Double), @TurtleBuilder builder:()-> [Command]) {
		self.initialLocation = initialLocation
		self.commands = builder()
	}

	public convenience init(_ x: Double, _ y: Double, @TurtleBuilder builder:()-> [Command]) {
		self.init((x, y), builder:builder)
	}

	static func deg2rad(_ number: Double) -> Double {
		return number * .pi / 180
	}

	public lazy var points = self.complie()

	func exec(_ command: Command, points:inout [(Double, Double)],  radian: inout Double) {
		switch command {
		case .forward(let length):
			let x = cos(radian) * Double(length)
			let y = sin(radian) * Double(length)
			let lastPoint = points.last!
			points.append((lastPoint.0 + x, lastPoint.1 +  y))
		case .turn(let degree):
			let rad = Turtle.deg2rad(Double(degree))
			radian += rad
		case .loop(let count, let commands):
			for _ in 0..<count {
				for command in commands {
					exec(command, points: &points, radian: &radian)
				}
			}
		case .pass:
			break
		}
	}

	func complie() -> [(Double, Double)] {
		var points:[(Double, Double)] = [initialLocation]
		var radian: Double = 0
		for command in self.commands {
			exec(command, points: &points, radian: &radian)
		}
		return points
	}
}
