-- find # of distinct values
a) select count(*) from venues;
-- list all events that were held on ISU campus
b) select vid, sched_date from events where location='ISU Campus';
-- count number of distinct events held at each location
c) select location, count(*) from events group by location;
-- find the events that dean or john has participated in
d) select events.vid, events.sched_date, events.location
from persons, participates, events
where participates.pid=persons.pid
and participates.vid=events.vid
and participates.sched_date=events.sched_date
and (persons.pname='John' or persons.pname='Dean');
-- find events that all three people john, mary and jane participated in
e) select e.vid, e.sched_date, e.location
from events e, persons p1, persons p2, persons p3,
participates pp1, participates pp2, participates pp3,
where p1.pname='Mary' and p1.pid=pp1.pid and pp1.vid=e.vid and pp1.sched_date=e.sched_date
and p2.pname='John' and p2.pid=pp2.pid and pp2.vid=e.vid and pp2.sched_date=e.sched_date
and p3.pname='Jane' and p3.pid=pp3.pid and pp3.vid=e.vid and pp3.sched_date=e.sched_date;
-- find all pnames of people that have not participated in any event
f) select p.pname
from persons p left join participates pp on p.pid=pp.pid
where pp.pid is null
order by p.pid desc;
-- find pid and pname that participate in more than or equal to two
g) select p.pid,
from persons p, participates pp
where p.pid=pp.pid
group by p.pid, p.pname
having count(distinct pp.vid) >= 2;
-- write a query with a sub-query in the venue
h) select venues.id venues.vname
from venues v
where not exists (
    select * from events e
    where e.vid=v.venue_id
);
-- write a sub-query in the where clause using the in operator to find the venue that has had events located in Houstin, TX
i) select venues.venue.venue_id venues.vname
from
where
--
j)
