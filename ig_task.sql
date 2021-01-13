-- Find 5 Oldest Users
select * from users
order by created_at
limit 5;

-- Most Popular Register Date
select 
    DAYNAME(created_at) as Day,
    count(*) as Frequency
from users
group by  Day
order by Frequency desc
limit 2;


-- Find user never post a photo 
select username
from users 
where id not in (select user_id
                 from photos
                );
                
SELECT username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Find most popular photo (or users who created)
select username,photos.id, photos.image_url,count(*) as total 
from photos
inner JOIN likes
on photos.id=likes.photo_id
inner join users
on photos.user_id=users.id 
group by photos.id
order by total desc
limit 1;


-- Calculate average number of photos per user
SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg; 
                          
-- Find the five most popular hashtags    
select tags.tag_name,count(*) as total
from photo_tags
join tags 
on photo_tags.tag_id=tags.id 
group by tags.id
order by total desc
limit 5;

-- Finding the bots - the users who have liked every single photo

SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos); 