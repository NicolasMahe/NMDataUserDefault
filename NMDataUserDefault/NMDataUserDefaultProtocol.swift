//
//  NMDataUserDefaultEnum.swift
//  NMDataUserDefaultEnum
//
//  Created by Nicolas Mahé on 06/03/2017.
//
//

import UIKit

protocol NMDataUserDefaultProtocol {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  associatedtype ValueType
  
  var identifier: String { get set }
  var store: UserDefaults { get set }
  var defaultValue: ValueType { get set }
  var enableInMemory: Bool { get set }
  var onChange: (() -> Void)? { get set }
  
  var _value: ValueType? { get set }
  
  //----------------------------------------------------------------------------
  // MARK: - Life cycle
  //----------------------------------------------------------------------------
  
  init(
    identifier: String,
    store: UserDefaults,
    defaultValue: ValueType,
    enableInMemory: Bool,
    onChange: (() -> Void)?
  )
  
  //----------------------------------------------------------------------------
  // MARK: - Archive / unarchive
  //----------------------------------------------------------------------------
  
  //See https://github.com/radex/SwiftyUserDefaults/blob/master/Sources/SwiftyUserDefaults.swift#L442
  
  //Others
  func archive(_ value: ValueType) -> Any?
  func unarchive() -> ValueType?
}


extension NMDataUserDefaultProtocol {
  
  //----------------------------------------------------------------------------
  // MARK: - Notification
  //----------------------------------------------------------------------------
  
  public var notification: Notification.Name {
    return Notification.Name(rawValue: self.identifier)
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Value
  //----------------------------------------------------------------------------
  
  public var value: ValueType {
    mutating get {
      //get from memory
      if self.enableInMemory == true,
        let value = self._value {
        return value
      }
      
      if let value = self.unarchive() {
        self._value = value
        return value
      }
      
      //get default asset
      return self.defaultValue
    }
    set(value) {
      //Set in memory
      self._value = value
      
      if let data = self.archive(value) {
        self.store.set(data, forKey: self.identifier)
      }
      else {
        self.store.removeObject(forKey: self.identifier)
      }
      
      //send notif
      NotificationCenter.default.post(
        name: self.notification,
        object: nil
      )
      
      self.onChange?()
    }
  }
  
}
