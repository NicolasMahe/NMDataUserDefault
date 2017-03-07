//
//  NMDataUserDefaultEnum.swift
//  NMDataUserDefaultEnum
//
//  Created by Nicolas Mahé on 06/03/2017.
//
//

import UIKit


public class NMDataUserDefaultEnum<T: RawRepresentable>: NSObject, NMDataUserDefaultProtocol {
  
  public typealias ValueType = T?
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  var identifier: String
  var store: UserDefaults
  var defaultValue: ValueType
  var enableInMemory: Bool
  var onChange: (() -> Void)?
  
  var _value: ValueType?
  
  //----------------------------------------------------------------------------
  // MARK: - Life cycle
  //----------------------------------------------------------------------------
  
  required public init(
    identifier: String,
    store: UserDefaults = UserDefaults.standard,
    defaultValue: ValueType,
    enableInMemory: Bool = true,
    onChange: (() -> Void)? = nil
    ) {
    self.identifier = identifier
    self.store = store
    self.defaultValue = defaultValue
    self.enableInMemory = enableInMemory
    self.onChange = onChange
    
    super.init()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Archive / unarchive
  //----------------------------------------------------------------------------

  func archive(_ value: ValueType) -> Any? {
    return value?.rawValue
  }
  func unarchive() -> ValueType? {
    if let data = self.store.object(forKey: self.identifier),
      let dataRaw = data as? T.RawValue {
      return T(rawValue: dataRaw)
    }
    return nil
  }
}
