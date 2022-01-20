# Intro to Databases and Database Management Systems

By: Dr. Pak

Databases make sure that user's data is safe and storable

Efficient access and sharing

#### Entities vs Properties

Things are call _entities_

Attributes are called _properties_

- Student : entitiy

- GPA: property

properties correspond to columns and entities correspond to rows

ER models: Thing or a real-world object distinguishable from other objects

Key: A minimal set of attributes whose value together are distinct for each individual entity for all the entities in the same entity set

Relationship: Association among two or more entities

Relationship Set: Each supply relationship is uniquely identified by sid, pid, and jid

#### Constraints

Structural Constraints specifies the number of relationships that an entity can participate in
-  *ex: 1-to-1 or 1-to-Many*

Key Constraints
- Specifies that each entity of an entity set can participate in __at most one__ relationship in a relationship set
- &rarr; &larr;

Participation Constraints
- __Every entity must participate__ in the entity set
- &rarr; __&larr;__
