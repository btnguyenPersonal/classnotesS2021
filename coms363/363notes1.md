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

#### Update anomaly

  - If one copy of such repeated data is updated, an inconsistency is created unless all copies are similarly updated

#### Insertion anomaly

  - It may not be possible to store some information unless some other information is stored as well

#### Deletion anomaly:

  - It may not be possible to delete some information without losing some other information as well

#### ER to Relational Data Model

  - We want to keep entities and relationships in a given ER diagram and

    - all the constraints in the ER diagram

    - constraints that ER notations cannot enforce

    - creating only necessary relations

    - reduce redundancy

## Structured Query Language (SQL)

  - Data Definition Language (DDL) enables creation, deletion, and modification of relation schemas, views, and integrity constraint specification.

  - Data Manipulation Language (DML) allows users to query, to insert, to delete rows, and update column values

    - Based on first-order tuple calculus

  - Doesn't let you delete a column if it referenced somewhere else

  - Could do _Cascade Deletion_ where you can delete that column, and every column that references that column

    - This is used for weak entity sets

## Graph DBMS

- Data is stored in nodes and graphs

- Neo4j uses the Cypher language

```cypher
match (:Suppliers)-[e:SUPPLIES]->(:Parts) return count(e)
```
621

```cypher
match (:Parts{color:'blue'})<-[:SUPPLIES]-(:Suppliers)-[e:SUPPLIES]->(:Parts{color:'black'}) return distinct s.sid, s.sname order by s.sid
```

number of bytes per row = 4 + 30 + 66 = 100

number of rows per page = floor(2000/100) = 20

number of pages = ceiling(10000/20) = 500

a)
b)
c)
d)
e)
f)
g)
