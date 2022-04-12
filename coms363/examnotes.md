## remember left join

left join takes everything from left, and will make null if no corresponding thing (so can check if null or not for relationships exists)

## group by if counting number of things done by entity

group by will aggregate all current results and combine them by values

## nesting statements

where v.vid in
(
 select * from events where e.location = 'Des Moines'
);

think of each nesting as a filter, like take distinct eid where salary > 2000000, then filter out the eid in the surrounding select
