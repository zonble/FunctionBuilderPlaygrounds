import Foundation

public enum Op {
	case add, minus, multiply, divide
}

public var add = Op.add
public var minus = Op.minus
public var multiply = Op.multiply
public var divide = Op.divide

@_functionBuilder
public class MathBuilder {
	public static func buildBlock(_ op: Op, _ items: Int...) -> Int {
		switch op {
		case .add:
			return items.reduce(0) { x, y in x + y }
		case .minus:
			return items.count > 1 ?
				items[1...].reduce(items.first!) { x, y in x - y } :
				items.first!
		case .multiply:
			return items.reduce(1) { x, y in x * y }
		case .divide:
			return items.count > 1 ?
				items[1...].reduce(items.first!) { x, y in x / y } :
				items.first!
		}
	}
}

public func __(@MathBuilder _ builder: ()->Int) -> Int {
	return builder()
}

public func test() {
	let x = __ {
		Op.add
		1
		2
	}
	print(x)
}
