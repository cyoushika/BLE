//
//  PeripheralManager.swift
//  CB_PeripheralTester
//
//  Created by zhangzhihua on 2017/3/9.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEPeripheralManager : NSObject,CBPeripheralManagerDelegate{
    var peripheralManager: CBPeripheralManager!
    var characteristic = CBMutableCharacteristic(type: CharacteristicUUID, properties: CBCharacteristicProperties.notify, value: nil, permissions: CBAttributePermissions.readable)
    
    func setup()
    {
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func teardown()
    {
        self.peripheralManager = nil
    }
    
    func startAdvertsing()
    {
        self.peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey:[ServiceUUID]])
    }
    
    func stopAdvertsing()
    {
        self.peripheralManager.stopAdvertising()
    }
    
    func sendData()
    {
        
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        self.sendData()
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        print("Did Unsubscribe From Characteritic")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if let error = error
        {
            print("Failed to add a service..Error:\(error)")
            return
        }
        print("Add Service Successfully!")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        print("Did Received Read Request")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        print("Did Received Write Request")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, willRestoreState dict: [String : Any]) {
        print("Will Restore State")
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error
        {
            print("Failed to start advertising..Error:\(error)")
            return
        }
        print("Start advertising Successfully")
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("The State of PeripheralManager has been changed")
        print("The State of PeripheralManager for now is \(peripheral.state)")
        
        if peripheral.state != CBManagerState.poweredOn{
            print("There is something wrong with state")
            return
        }
        
        let service = CBMutableService(type: ServiceUUID, primary: true)
        service.characteristics = ["还没设计好"]
        peripheral.add(service)
    }
    
    func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
        self.sendData()
    }
}
