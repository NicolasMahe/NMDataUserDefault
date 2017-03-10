//
//  NMDataUserDefault.swift
//  NMDataUserDefault
//
//  Created by Nicolas Mahé on 06/03/2017.
//
//

import UIKit

//@todo: facto code as possible

public class NMDataUserDefault<T>: NSObject {//, NMDataUserDefaultProtocol {
  
  public typealias ValueType = T
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  var identifier: String
  var store: UserDefaults
  var defaultValue: ValueType
  public var enableInMemory: Bool
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
    return NSKeyedArchiver.archivedData(withRootObject: value)
  }
  func unarchive() -> ValueType? {
    if let data = self.store.data(forKey: self.identifier) {
      return NSKeyedUnarchiver.unarchiveObject(with: data) as? T
    }
    return nil
  }
  
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
    get {
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
