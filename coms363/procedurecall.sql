create procedure showNumReservations()
select s.sid, s.name, count(*)
from sailor s, reserves r
where s.sid = r.sid
group by s.sid, s.sname;

call showNumReservations();

create procedure increaseRating(
in sailor_sid integer, in increase integer)
	update sailors
	set rating = rating + increase
	where sid = sailor_sid;

call increaseRating(22,1);

drop procedure if exists suppliersWithoutParts;

delimiter //
create procedure suppliersWithoutParts

delimiter;