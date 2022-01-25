# Intro to Databases and Database Management Systems

By: Dr. Pak

## Upsides of Database Management
- Databases make sure that user's data is safe and storable
- Efficient access and sharing

## Entities vs Properties

- Things are call _entities_
  - Student
- Attributes are called _properties_
  - GPA

### Symbols
  - Key
    - A minimal set of attributes whose value together are distinct for each individual entity for all the entities in the same entity set
  - Entity Set &rarr; set of similar entities (Students, or Employees)
  - Relationship Set &rarr; set of similar relationships (isBoss)
  - __Bold__ Symbols mean weak entity set or identifying relationship set
  - Circle is attribute
    - partial underline is partial key (weak entity set only)
    - full underline is for key attribute

#### Constraints
Structural Constraints specifies the number of relationships that an entity can participate in
-  *ex: 1-to-1 or 1-to-Many*

#### Key Constraints
- Specifies that each entity of an entity set can participate in __at most one__ relationship in a relationship set
- E &rarr; R &larr; E

#### Participation Constraints
- __Every entity must participate__ in the entity set
- E __--->__ R &larr; E

#### Weak Entity Set
  - A partial key has a dashed underline below the attribute name
  - This does not uniquely identity things connected to it

## Relationship with own entity set
  - can put diamond's both ends in an entity set
  - diamonds ___DO NOT___ connect directly to each other
  - rectangles ___DO NOT___ connect directly to each other

___Note___: Attributes can connect to relationships if they relate to all parties
