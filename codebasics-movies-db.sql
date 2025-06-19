use moviesdb;

select * from movies;

select industry, studio from movies;

select distinct industry from movies;

select count(*) from movies where industry = "bollywood";
select count(*) from movies where industry = "hollywood";

select * from movies where title like "%thor%";

select * from movies where imdb_rating >= 9;

select * from movies where imdb_rating between 6 and 8;

select * from movies where release_year in(2018, 1019, 2022);

select * from movies
where industry = "hollywood"
order by imdb_rating desc limit 5;

select MAX(imdb_rating) from movies where industry = "hollywood";

select avg(imdb_rating) from movies where studio = "Marvel Studios";
   
select studio, count(*) as cnt,
round(avg(imdb_rating),1) as avg_rating
from movies where studio != ""
group by studio
order by avg_rating desc;

select release_year, count(*) as movies_count
from movies
group by release_year
having movies_count > 2
order by movies_count desc; 

select *, year(curdate()) - birth_year as age from actors;

select *, (revenue-budget) as profit from financials;

select *,
if(currency = 'USD', revenue*77, revenue) as revenue_inr
from financials;

select *,
case
	when unit = "thousands" then revenue / 1000
    when unit ="billions" then revenue * 1000
    when unit = "millions" then revenue
end as revenue_millions
from financials;

select
	m.movie_id, title, budget, revenue, currency, unit
from movies m left join financials f on m.movie_id = f.movie_id
union
select
	m.movie_id, title, budget, revenue, currency, unit
from movies m right join financials f on m.movie_id = f.movie_id;



































