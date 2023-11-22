select* from  connected;
select * from workers;
select * from wants_to_work_with;

--First we will have to self join workers table to get name of wants_to_work_with table 
--having ID1 and ID2 which is nothing but workers id

select * from wants_to_work_with www, workers w1, workers w2 
where (w1.id = www.id1 and w2.id = www.id2 );

-- Then we need to identify the connection between these 2 employee. We want the 2 are not connected
-- for this we will use not in clause from connected table

select * from workers w1, workers w2, wants_to_work_with www
where (w1.id = www.id1 and w2.id = www.id2 ) and w1.id not in (
	select id2 from connected where id1 = w2.id);


-- now as per result in assignment, we have to print 3 set of name company in single row so now 
-- we will connect all 3 workers table id (Primary Key) with connected tables both column which is
-- nothing but workers itself.

select w1.name, w1.company, w2.name, w2.company, w3.name, w3.company
from workers w1, workers w2, workers w3, wants_to_work_with www, connected c1, connected c2
where (w1.id = www.id1 and w2.id = www.id2 ) 
and w1.id not in (select id2 from connected where id1 = w2.id) 
and (w1.id=c1.id1 and w3.id = c1.id2)
and (w2.id=c2.id1 and w3.id = c2.id2);	




