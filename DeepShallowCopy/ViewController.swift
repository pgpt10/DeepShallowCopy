//
//  ViewController.swift
//  DeepShallowCopy
//
//  Created by Payal Gupta on 04/06/18.
//  Copyright © 2018 Payal Gupta. All rights reserved.
//

import UIKit

class Person: Codable, NSCopying
{
    var name: String?
    var address: Address?
    
    init(_ name: String, _ address: Address)
    {
        self.name = name
        self.address = address
    }
    
    init() {}
    
    func copy(with zone: NSZone? = nil) -> Any
    {
        let p = Person()
        p.name = self.name
        p.address = self.address?.copy() as? Address
        return p
    }
}

class Address: Codable, NSCopying
{
    var city: String?
    init(_ city: String)
    {
        self.city = city
    }
    
    init() {}
    
    func copy(with zone: NSZone? = nil) -> Any
    {
        let a = Address()
        a.city = self.city
        return a
    }
}

struct Employee: Codable
{
    var name: String?
    var address: Address?
    
    init(_ name: String, _ address: Address)
    {
        self.name = name
        self.address = address
    }
}

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //----Reference Types-----
        let p1 = Person("P1", Address("A1"))
        
        //Shallow Copy - only reference is copied
        let p2 = p1
        
        //Deep copy - using copyWithZone
        //Value types - created a deep copy
        //Reference types - created a shallow copy
        //Doesn't create a true deep copy if all the nested object types are not copied using copyWithZone
        let p3 = p1.copy() as! Person
        
        //True deep copy - Serializing and De-serializing data creates a deep copy
        var p4: Person?
        if let data = try? JSONEncoder().encode(p1)
        {
            p4 = try? JSONDecoder().decode(Person.self, from: data)
        }
        
        //----Value Types----
        var e1 = Employee("P1", Address("A1"))
        
        //Shallow Copy
        //Value types - created deep copy
        //Reference types - created shallow copy
        var e2 = e1
        
        //True deep copy - Serializing and De-serializing data creates a deep copy
        var e3: Employee?
        if let data = try? JSONEncoder().encode(e1)
        {
            e3 = try? JSONDecoder().decode(Employee.self, from: data)
        }
    }
}

