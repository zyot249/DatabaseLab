with course_of_gries as(
	select distinct on("oID") oID" 
	from "Offering"
	where instructor = 'Gries')
select * from "Student"
where "sID" in (select "sID" from (select distinct on("sID", "oID") "sID", "oID"
								  from "Took"
								  where "oID" in course_of_gries) 
			   	group by("sID")
			   	having count("oID") = (select count(*) from course_of_gries));
				

-- test distinct
select distinct on(customerid, orderid) customerid
from cust_hist
where orderid >= 100;