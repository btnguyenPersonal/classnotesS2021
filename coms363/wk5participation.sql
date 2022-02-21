a)
Select count(eid) as numEmployees from emp

b)
select did, dname
from dept
where managerid is not null;

c)
select ename, salary
from emp
where salary > 2000000
order by salary;

d)
Select *
from dept  d1, dept d2
where d1.dname = 'Accounting' and d2.dname = 'Production';

e)
select e.ename, e.salary, 
from emp e, dept d, works w
where e.eid=w.eid and w.did=d.did and d.dname='Accounting';

f)
select w1.eid
from works w1, dept d1
where w1.did = d1.did and d1.dname='Production'
and exists
(select *
from works w2, dept d2
where w2.did=d2.did and d2.dname='Maintenance' and
w1.eid = w2.eid);

Select e.eid, e.ename
From emp e, dept d1, dept d2, works w1, works w2
Where d1.dname='Production' and d2.dname='Maintenance'

g)
Select d.did, count(e.sal)
From dept d left join works w on e.eid=w.eid
Where w.eid is not null;

g)

LEFT JOIN

Select e.eid
From emp e left join works w on e.eid=w.eid
Where w.eid is null;

EXISTS

select e.eid
from emp e 
where not exists
	(select *
    from works w
    where w.eid=e.eid);

IN

select e.eid
from emp e 
where e.eid not in
	(w.eid);
