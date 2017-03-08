import UIKit
import XCTest
import NMDataUserDefault

class Tests: XCTestCase {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  var dataBool = NMDataUserDefault<Bool>(
    identifier: "dataBool",
    store: UserDefaults.standard,
    defaultValue: false,
    enableInMemory: false
  )
  
  var dataInt = NMDataUserDefault<Int>(
    identifier: "int",
    store: UserDefaults.standard,
    defaultValue: 0,
    enableInMemory: false
  )
  
  var dataIntOptionnal = NMDataUserDefault<Int?>(
    identifier: "dataIntOptionnal",
    store: UserDefaults.standard,
    defaultValue: nil,
    enableInMemory: false
  )
  
  var dataString = NMDataUserDefault<String>(
    identifier: "string",
    store: UserDefaults.standard,
    defaultValue: "Nico",
    enableInMemory: false
  )
  
  var dataObject = NMDataUserDefault<ClassTest>(
    identifier: "classTest",
    store: UserDefaults.standard,
    defaultValue: ClassTest(valueTest: "defaultValue"),
    enableInMemory: false
  )
  
  var dataArrayString = NMDataUserDefault<[String]>(
    identifier: "arrayString",
    store: UserDefaults.standard,
    defaultValue: ["defaultValue"],
    enableInMemory: false
  )
  
  var dataArrayObject = NMDataUserDefault<[ClassTest]>(
    identifier: "arrayClassTest",
    store: UserDefaults.standard,
    defaultValue: [ClassTest(valueTest: "defaultValue")],
    enableInMemory: false
  )
  
  var dataArrayObjectOptionnal = NMDataUserDefault<[ClassTest]?>(
    identifier: "arrayClassTestOptionnal",
    store: UserDefaults.standard,
    defaultValue: nil,
    enableInMemory: false
  )
  
  var dataArrayObjectOptionnal2 = NMDataUserDefault<[ClassTest?]?>(
    identifier: "dataArrayObjectOptionnal2",
    store: UserDefaults.standard,
    defaultValue: nil,
    enableInMemory: false
  )
  
  var dataEnum = NMDataUserDefaultEnum<EnumTest>(
    identifier: "EnumTest",
    store: UserDefaults.standard,
    defaultValue: EnumTest.hello,
    enableInMemory: false
  )
  
  var dataEnumOptionnal = NMDataUserDefaultEnumOptionnal<EnumTest>(
    identifier: "dataEnumOptionnal",
    store: UserDefaults.standard,
    defaultValue: nil,
    enableInMemory: false
  )
  
  var dataEnumArray = NMDataUserDefaultArrayEnum<EnumTest>(
    identifier: "dataEnumArray",
    store: UserDefaults.standard,
    defaultValue: nil,
    enableInMemory: false
  )
  
  //----------------------------------------------------------------------------
  // MARK: - Test config
  //----------------------------------------------------------------------------
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Tests
  //----------------------------------------------------------------------------
  
  func testBool() {
    self.dataBool.value = true
    XCTAssert(self.dataBool.value == true)
  }
  
  func testInt() {
    self.dataInt.value = 1
    XCTAssert(self.dataInt.value == 1)
  }
  
  func testIntOptionnal() {
    self.dataIntOptionnal.value = 1
    XCTAssert(self.dataIntOptionnal.value == 1)
    
    self.dataIntOptionnal.value = nil
    XCTAssert(self.dataIntOptionnal.value == nil)
  }
  
  func testString() {
    self.dataString.value = "Thomas"
    XCTAssert(self.dataString.value == "Thomas")
  }
  
  func testArrayString() {
    self.dataArrayString.value = ["value_ewewe"]
    XCTAssert(self.dataArrayString.value == ["value_ewewe"])
  }
  
  func testObject() {
    self.dataObject.value = ClassTest(valueTest: "aValue")
    XCTAssert(self.dataObject.value.valueTest == "aValue")
  }
  
  func testArrayObject() {
    self.dataArrayObject.value = [
      ClassTest(valueTest: "aValue"),
      ClassTest(valueTest: "anotherValue")
    ]
    XCTAssert(self.dataArrayObject.value.first?.valueTest == "aValue")
    XCTAssert(self.dataArrayObject.value.last?.valueTest == "anotherValue")
  }
  
  func testArrayObjectOptionnal() {
    self.dataArrayObjectOptionnal.value = [
      ClassTest(valueTest: "aValue"),
      ClassTest(valueTest: "anotherValue")
    ]
    XCTAssert(self.dataArrayObjectOptionnal.value?.first?.valueTest == "aValue")
    XCTAssert(self.dataArrayObjectOptionnal.value?.last?.valueTest == "anotherValue")
    
    self.dataArrayObjectOptionnal.value = nil
    XCTAssert(self.dataArrayObjectOptionnal.value == nil)
  }
  
  func testArrayObjectOptionnal2() {
    self.dataArrayObjectOptionnal2.value = [
      ClassTest(valueTest: "aValue"),
      nil
    ]
    XCTAssert(self.dataArrayObjectOptionnal2.value?.first??.valueTest == "aValue")
    XCTAssert(self.dataArrayObjectOptionnal2.value?.last??.valueTest == nil)
    
    self.dataArrayObjectOptionnal.value = nil
    XCTAssert(self.dataArrayObjectOptionnal.value == nil)
  }
  
  func testEnum() {
    self.dataEnum.value = .goodbye
    XCTAssert(self.dataEnum.value == .goodbye)
  }
  
  func testEnumOptionnal() {
    self.dataEnumOptionnal.value = .goodbye
    XCTAssert(self.dataEnumOptionnal.value == .goodbye)
    
    self.dataEnumOptionnal.value = nil
    XCTAssert(self.dataEnumOptionnal.value == nil)
  }
  
  func testEnumArrayOptionnal() {
    self.dataEnumArray.value = [.goodbye, .hello]
    XCTAssert(self.dataEnumArray.value?.first == .goodbye)
    XCTAssert(self.dataEnumArray.value?.last == .hello)
  }
  
}

//----------------------------------------------------------------------------
// MARK: - Help class and enum
//----------------------------------------------------------------------------

class ClassTest: NSObject, NSCoding {
  
  var valueTest: String
  
  init(valueTest: String) {
    self.valueTest = valueTest
    super.init()
  }
  
  convenience required public init?(coder decoder: NSCoder) {
    guard let valueTest = decoder.decodeObject(forKey: "valueTest") as? String
      else {
        return nil
    }
    
    self.init(
      valueTest: valueTest
    )
  }
  
  public func encode(with coder: NSCoder) {
    coder.encode(self.valueTest, forKey: "valueTest")
  }
}

enum EnumTest: Int {
  case hello
  case goodbye
}
