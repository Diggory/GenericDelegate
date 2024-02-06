//	Generic Delegate

let client = Client()
client.setup()
client.useLibrary()


protocol LibraryDelegate {
	func somethingDone<T>(resultWas: T?)
}

class Library {
	var delegate: LibraryDelegate?
	let anInt = 1
	let aString = "I am a String!"
	
	//	Sometimes returns a string, sometimes an Int
	func doSomething() {
		print("Library: doSomething()")
		
		if Int.random(in: 1..<10).isMultiple(of: 2) {
			self.delegate?.somethingDone(resultWas: self.anInt)
		} else {
			self.delegate?.somethingDone(resultWas: self.aString)
		}
	}
}

class Client: LibraryDelegate {
	var library = Library()
	
	func setup() {
		library.delegate = self
	}
	
	func useLibrary() {
		library.doSomething()
	}
	
	//	LibraryDelegate Conformance
	func somethingDone<T>(resultWas genericResult: T?) {
		print("Client: Something was done by the Library.")
		print("Client: genericResult: \(String(describing: genericResult))")
		if let unwrappedGenericResult = genericResult {
			print("optional was unwrapped.")
			if type(of: unwrappedGenericResult) == Int.self {
				print("The unwrappedGenericResult is of type Int")
				print("Type of unwrappedGenericResult: \(type(of: unwrappedGenericResult))")
				print("unwrappedGenericResult: \(unwrappedGenericResult)")
//				if unwrappedGenericResult == 1 {	//	ERROR: Binary operator '==' cannot be applied to operands of type 'T' and 'Int'
//					print("It is 1!")
//				}
				
			}

		}
	}
	
	
}
