# Deep and Shallow Copy in Swift


## Shallow copy

    1. Shallow copies duplicate as little as possible. A shallow copy of a collection is a copy of the collection structure, not the elements. With a shallow copy, two collections now share the individual elements.

    2. With a shallow copy, any object pointed to by the source is also pointed to by the destination (so that no referenced objects are copied).

    3. Swallow copies are faster to create because sharing the reference only. The created copies does not entirely create new instance in memory instead only address/reference is copied.

## Deep copy

    1. Deep copies duplicate everything. A deep copy of a collection is two collections with all of the elements in the original collection duplicated.

    2. With a deep copy, any object pointed to by the source is copied and the copy is pointed to by the destination (so there will now be 2 of each referenced object). This recurses down the object tree.

    3. Deep copies are less prone to race conditions and suits well in multithreaded environment. You are sure the object on which you are performing changes will impact only same object. It will not make any impact on the source object. This is one of the reason also why apple have made collection types (Array, Dictionary, Set) as value types in Swift (which are reference types in Objective C).


## Value types

- Deep copy / Copy Content — For example Structure, Array, Dictionary, Set, String etc.
- Copying (e1: Employee struct)

        1. e2 = e1
                1. creates a deep copy if e1 contains only value types.
                2. creates a shallow copy if e1  contains both value and nested object types.

        2. Serializing/De-serializing — creates true deep copy — use Codable/Archive-Unarchive
	
## Reference types 

- Shallow copy (by default) / Copy Reference —  For example Classes.
- Copying (p1: Person object — contains both value and nested object types)

        1. p2 = p1 — creates a shallow copy

        2. p2 = p1.copy() — creates partial shallow copy 
                1.  Use NSCopying protocol and implement func copy(with zone: NSZone? = nil) -> Any on the object you want to make copy of.
                2. Value types - created a deep copy
                3. Reference types - created a shallow copy
                4. Doesn't create a true deep copy if all the nested object types are not copied using copyWithZone

        3. Serializing/De-serializing — creates true deep copy — use Codable/Archive-Unarchive

## Copy on Write — Native Swift value types
 
- when assigned, each reference points to the same memory address. It’s only when one of the references modifies the underlying data that Swift actually copies the original instance and makes the modification.

- A new copy should be created only if a change is performed in any of the object.

- That is, be it deep copy or shallow copy, a new copy will not be created until you make a change in copied object.


