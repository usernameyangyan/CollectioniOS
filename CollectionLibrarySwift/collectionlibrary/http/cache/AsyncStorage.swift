//
//  AsyncStorage.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2020/1/16.
//  Copyright © 2020 YoungManSter. All rights reserved.
//

import Foundation
import Dispatch

/// Manipulate storage in a "all async" manner.
/// The completion closure will be called when operation completes.
public class AsyncStorage<T> {
  public let innerStorage: HybridStorage<T>
  public let serialQueue: DispatchQueue

  public init(storage: HybridStorage<T>, serialQueue: DispatchQueue) {
    self.innerStorage = storage
    self.serialQueue = serialQueue
  }
}

extension AsyncStorage {
  public func entry(forKey key: String, completion: @escaping (CacheResult<Entry<T>>) -> Void) {
    serialQueue.async { [weak self] in
      guard let `self` = self else {
        completion(CacheResult.error(StorageError.deallocated))
        return
      }

      do {
        let anEntry = try self.innerStorage.entry(forKey: key)
        completion(CacheResult.value(anEntry))
      } catch {
        completion(CacheResult.error(error))
      }
    }
  }

  public func removeObject(forKey key: String, completion: @escaping (CacheResult<()>) -> Void) {
    serialQueue.async { [weak self] in
      guard let `self` = self else {
        completion(CacheResult.error(StorageError.deallocated))
        return
      }

      do {
        try self.innerStorage.removeObject(forKey: key)
        completion(CacheResult.value(()))
      } catch {
        completion(CacheResult.error(error))
      }
    }
  }

  public func setObject(
    _ object: T,
    forKey key: String,
    expiry: Expiry? = nil,
    completion: @escaping (CacheResult<()>) -> Void) {
    serialQueue.async { [weak self] in
      guard let `self` = self else {
        completion(CacheResult.error(StorageError.deallocated))
        return
      }

      do {
        try self.innerStorage.setObject(object, forKey: key, expiry: expiry)
        completion(CacheResult.value(()))
      } catch {
        completion(CacheResult.error(error))
      }
    }
  }

  public func removeAll(completion: @escaping (CacheResult<()>) -> Void) {
    serialQueue.async { [weak self] in
      guard let `self` = self else {
        completion(CacheResult.error(StorageError.deallocated))
        return
      }

      do {
        try self.innerStorage.removeAll()
        completion(CacheResult.value(()))
      } catch {
        completion(CacheResult.error(error))
      }
    }
  }

  public func removeExpiredObjects(completion: @escaping (CacheResult<()>) -> Void) {
    serialQueue.async { [weak self] in
      guard let `self` = self else {
        completion(CacheResult.error(StorageError.deallocated))
        return
      }

      do {
        try self.innerStorage.removeExpiredObjects()
        completion(CacheResult.value(()))
      } catch {
        completion(CacheResult.error(error))
      }
    }
  }

  public func object(forKey key: String, completion: @escaping (CacheResult<T>) -> Void) {
    entry(forKey: key, completion: { (result: CacheResult<Entry<T>>) in
      completion(result.map({ entry in
        return entry.object
      }))
    })
  }

  public func existsObject(
    forKey key: String,
    completion: @escaping (CacheResult<Bool>) -> Void) {
    object(forKey: key, completion: { (result: CacheResult<T>) in
      completion(result.map({ _ in
        return true
      }))
    })
  }
}

public extension AsyncStorage {
  func transform<U>(transformer: Transformer<U>) -> AsyncStorage<U> {
    let storage = AsyncStorage<U>(
      storage: innerStorage.transform(transformer: transformer),
      serialQueue: serialQueue
    )

    return storage
  }
}

