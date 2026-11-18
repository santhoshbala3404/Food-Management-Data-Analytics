create database food_storage;
use food_storage;

describe table foodlist;
describe table providers;
describe table receiver;
describe table claims;
--1. Food Providers and Receivers

select city, count(distinct name) as no_of_providers from providers group by city;
select city, count(distinct name) as no_of_receivers from receiver group by city;

select provider_type, count(*) as no_of_contribution from foodlist group by provider_type order by no_of_contribution desc limit 1;

select address, contact from providers where city='Tinamouth';


--2. Food listing and Availability
select sum(quantity) as total_food_available from foodlist;

select p.city, count(*) as no_of_providers from providers p join foodlist f on p.provider_id=f.provider_id group by p.city order by no_of_providers desc limit 2;

select food_name from foodlist group by food_name order by count(*) desc limit 5;


--3. Claims and distribution
select food_name, count(*) as no_of_claims from foodlist group by food_name;

select status, round((count(*) * 100/(select count(*) from claims)),2) as percentage from claims group by status;

select p.name, count(*) as no_of_successful_claims from providers p join foodlist f on p.provider_id=f.provider_id join claims c on c.food_id=f.food_id where c.status='Completed' group by p.name order by no_of_successful_claims desc limit 1;

--4. Analysis and insights
select meal_type, count(*) from foodlist group by meal_type order by count(*) desc limit 1;

select food_type, count(*) from foodlist group by food_type order by count(*) desc;

select p.name, sum(f.quantity) as total_quantity_of_food_donated from providers p join foodlist f on p.provider_id=f.provider_id group by p.name;

select r.name, round(avg(f.quantity),2) as average_qunatity_claimed from receiver r join claims c on r.receiver_id=c.receiver_id join foodlist f on f.food_id=c.food_id group by r.name;

