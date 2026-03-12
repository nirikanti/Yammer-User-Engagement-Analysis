select * from [dbo].[email] as e;
select * from [dbo].[event] as v;
select * from [dbo].[users] as u ;
--1--

select count(*) as registration, 
year(u.created_at) as years,
month(u.created_at) as months
from [dbo].[users] as u 
group by year(u.created_at) , month(u.created_at)
order by years,months;
--2--

select Count(*) as registration,state from 
[dbo].users as u 
where language  <> 'english'
group by u.state ;
--3--
with count_lan as (
select 
count(*) as registrations, language 
from [dbo].users as u 
group by u.language
),
 
ranked_lan as (
select * ,
 rank() over (order by registrations desc )as  top_3,
 rank() over (order by registrations asc) as  bottom_3
 from count_lan 
 )
 select registrations , language from ranked_lan
  
 where top_3 <=3 or bottom_3 <=3 
 order by registrations desc;
 
 --4--
 select v.location as country ,avg(DATEDIFF(SECOND,created_at,activated_at)/3600.0)
 as avg_diff 
 from [dbo].[users] as u 
 join [dbo].event as v
 on u.user_id=v.user_id 
 where u.activated_at is not null
 group by location
 order by avg_diff;
 --5--
 SELECT v.device, COUNT(*) AS total_events
FROM [dbo].event as v
GROUP BY device
ORDER BY total_events DESC;

 --6--
 select count(distinct u.user_id)
 from [dbo].[users] as u  join [dbo].[event] as v
 on u.user_id=v.user_id;
 --7--
 select count(*) as registration 
 from [dbo].[users] as u join [dbo].[event]
 as v on u.user_id=v.user_id
 group by location
 where u.created_at == v.occurred_at ;
 
 --8--
 select count(*) as messages  ,location,device   from [dbo].[event]
 where event_name ='like_message'
 group by device ,Location;

 --9--
 select *,avg(created_at) from [dbo].users
 group by country 
 --10--
 select count(*) ,year(e.occurred_at)
 from [dbo].[email] as e join [dbo].users as u
 on  e.user_id=u.user_id
 group by occurred_at
 where language='janpanese';

 ###kpis
 select count(distinct u.user_id) 
 as active_users from [dbo].users as u;

 select count(*) from event as e
 where e.event_name ='like_message';

 select * from users;

 select COUNT(case when u.activated_at is not null
 then 1 end) * 100/ count(*) as activation_rate
 from [dbo].[users] as u ;

 select count(*) * 1.0/count(distinct e.user_id) as
 avg_event_user from [dbo].event as e

 ##Q2
  

  select * from event as e;

  select count(distinct user_id )from [dbo].users
  SELECT 
    e.location AS country,
    COUNT(e.event_type) * 1.0 / COUNT(DISTINCT e.user_id) / COUNT(DISTINCT DATEPART(week, e.occurred_at)) 
        AS avg_weekly_engagement_per_user
FROM event e
JOIN [dbo].users  u 
    ON e.user_id = u.user_id
GROUP BY e.location
ORDER BY avg_weekly_engagement_per_user DESC;
