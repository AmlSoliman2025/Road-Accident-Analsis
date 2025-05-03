select * from Road_accident

select count(accident_severity)as [Total serious accidents of year 2022], 
       sum(number_of_casualties) as [Total serious Casualtes of year 2022]
from Road_accident
where accident_severity = 'serious' and year(accident_date)=2022

select sum(number_of_casualties)as[casualties per month(2022)], FORMAT(accident_date,'MMMM') as[month trend] 
from Road_accident
where year(accident_date)=2022
group by FORMAT(accident_date,'MMMM') 
order by FORMAT(accident_date,'MMMM') desc

select sum(number_of_casualties)as[casualties per road type in 2022], road_type 
from Road_accident
where  year(accident_date)=2022
group by road_type
order by sum(number_of_casualties) desc

select sum(number_of_casualties)as[casualties per Area in 2022], urban_or_rural_area as [area]
from Road_accident
where  year(accident_date)=2022
group by urban_or_rural_area 
order by sum(number_of_casualties) desc

select top 10 sum(number_of_casualties)as[casualties per location in 2022], local_authority
from Road_accident
where  year(accident_date)=2022
group by local_authority
order by sum(number_of_casualties)desc

/*--k.	Casualties by lightening Condition in year 2022--*/
select count(*)as[casualties per light condition in 2022], light_conditions 
from Road_accident
where  year(accident_date)=2022
group by light_conditions
order by light_conditions desc

select sum(number_of_casualties), light_degree as [light condition]
from
(
select 
     case
	    when light_conditions like 'Darkness%' then 'Darkness'
		WHEN light_conditions LIKE 'Daylight%' THEN 'Daylight'
        
		  
     end as light_degree
	 from Road_accident
) as light_degree table

group by light_degree

SELECT 
    light_degree AS [light condition], 
    SUM(number_of_casualties) AS total_casualties
FROM
    (SELECT 
         CASE
             WHEN light_conditions LIKE 'Darkness%' THEN 'Darkness'
             WHEN light_conditions LIKE 'Daylight%' THEN 'Daylight'
             ELSE 'Unknown' 
         END AS light_degree,
         number_of_casualties
     FROM Road_accident
    ) AS light_degree_table
GROUP BY light_degree;

select count(*) as [number of accident per vehicle], vehicles
from
(
select
 case
 when vehicle_type like 'Mo%' or vehicle_type like 'pedal%' then 'Bikes'
when vehicle_type like 'Bu%' or vehicle_type like 'Mini%'then 'Buses'
when vehicle_type like 'Car%' or vehicle_type like 'Taxi%' then 'Cars'
when vehicle_type like 'van%' or vehicle_type like 'good%'then 'Vans'
when vehicle_type like 'Agricultrual%' then 'Agricultrual vehicle'
else 'others'
end as vehicles , accident_date
from Road_accident
)as vehicles_table
where year(accident_date)=2022
group by vehicles



















select count(*)as[accident per month(2022)], FORMAT(accident_date,'MMMM') as[month trend] 
from Road_accident
where year(accident_date)=2022
group by FORMAT(accident_date,'MMMM') 
order by FORMAT(accident_date,'MMMM') desc


select sum(number_of_casualties)as[casualties per month(2021)], FORMAT(accident_date,'MMMM') as[month trend] 
from Road_accident
where year(accident_date)=2021
group by FORMAT(accident_date,'MMMM') 
order by FORMAT(accident_date,'MMMM') desc

select vehicle_type, count(accident_index) as [number of accident per vehicle]
from Road_accident
group by vehicle_type

select count(accident_index) as [number of accident per vehicle], vehicles
from
(
select
     case 
	    when vehicle_type like 'Mo%' or vehicle_type like 'pedal%' then 'Bikes'
		when vehicle_type like 'Bu%' or vehicle_type like 'Mini%'then 'Buses'
		when vehicle_type like 'Car%' or vehicle_type like 'Taxi%' then 'Cars'
		when vehicle_type like 'van%' or vehicle_type like 'good%'then 'Vans'
		when vehicle_type like 'Agricultrual%' then 'Agricultrual vehicle'
		else  'others'

	end as	vehicles, count(accident_index) as [number of accident per vehicle]
	from Road_accident
)as  vehicles_table

group by vehicles
select * from Road_accident


SELECT 
    vehicles,
    COUNT(*) AS [number of accidents per vehicle]
FROM
    (SELECT 
         CASE 
             WHEN vehicle_type LIKE 'Mo%' OR vehicle_type LIKE 'Pedal%' THEN 'Bikes'
             WHEN vehicle_type LIKE 'Bu%' OR vehicle_type LIKE 'Mini%' THEN 'Buses'
             WHEN vehicle_type LIKE 'Car%' OR vehicle_type LIKE 'Taxi%' THEN 'Cars'
             WHEN vehicle_type LIKE 'Van%' OR vehicle_type LIKE 'Good%' THEN 'Vans'
             WHEN vehicle_type LIKE 'Agricultural%' THEN 'Agricultural vehicle'
             ELSE 'Others'
         END AS vehicles
     FROM Road_accident
    ) AS vehicles_table
GROUP BY vehicles;

select sum(number_of_casualties) as [number of casualties per vehicle], vehicles
from
(
select
   case
      when vehicle_type like 'Mo%' or vehicle_type like 'pedal%' then 'Bikes'
      when vehicle_type like 'Bu%' or vehicle_type like 'Mini%'then 'Buses'
      when vehicle_type like 'Car%' or vehicle_type like 'Taxi%' then 'Cars'
      when vehicle_type like 'van%' or vehicle_type like 'good%'then 'Vans'
      when vehicle_type like 'Agri%' then 'Agricultrual'
      else 'others'
   end as vehicles , accident_date, number_of_casualties
from Road_accident
)as vehicles_table
where year(accident_date)=2022
group by vehicles
order by sum(number_of_casualties) desc

select count(*) as [number of accident per vehicle], vehicles
from
(
select
     case 
	    when vehicle_type like 'Mo%' or vehicle_type like 'pedal%' then 'Bikes'
		when vehicle_type like 'Bu%' or vehicle_type like 'Mini%'then 'Buses'
		when vehicle_type like 'Car%' or vehicle_type like 'Taxi%' then 'Cars'
		when vehicle_type like 'van%' or vehicle_type like 'good%'then 'Vans'
		when vehicle_type like 'Agricul%' then 'Agricultrual'
		else  'others'

	end as	vehicles , accident_date
	from Road_accident
)as  vehicles_table
where  year(accident_date)=2022

group by vehicles
order by count(*) desc
select * from Road_accident

select cast((current_casualties -lastyear_casualties)*100/current_casualties  as float)
from
(select sum(number_of_casualties) as current_casualties from Road_accident
where year(accident_date) = 2022) as current2022,

(select sum(number_of_casualties) as lastyear_casualties from Road_accident
where year(accident_date) = 2021) as last2021

