# Blog API

Ruby 2.5.1

Rails 5.2.3

# 1. Create post
```
#POST api/v1/posts

request: {"post": {"title": "Post title", "body: "Post body", ip: "0.0.0.0", login: "John"}}
    
response: {"title": "Post title", "body": "Post body", "ip": "0.0.0.0", "rating": "5.0", "login": "John"}

```

# 2. Top X posts
```
#GET api/v1/posts/top?amount=X 

response: [{"title": "Nature", "body": "About nature"}, {"title": "Animals", "body": "About animals"}]
```
   
# 3. List of tricky ips
   
```
#GET api/v1/posts/ip_list

response: [{"ip": "37.214.36.20", "logins": ["John", "Alexandr"]}]
```   

# 4. Create a review
```
#POST api/v1/posts/{id}/reviews
  
request: {"review": {"mark": "5"}}
   
response: {"rating": "5.0"}   
```   
       
# SQL task

 * select continuous groups by group_id using specified order 
 
 * count records for each group
  
 * find minimum id for each group

```sql
CREATE TABLE users(id bigserial, group_id bigint);
INSERT INTO users(group_id) VALUES (1), (1), (1), (2), (1), (3); 

 id | group_id 
----+----------
  1 |        1
  2 |        1
  3 |        1
  4 |        2
  5 |        1
  6 |        3

select group_id,
       min(id) as min_id,
       count(group_id) as count 
from (select id,
             group_id,
             row_number() over (ORDER BY id) - row_number() over (partition by group_id order by id) 
             as groups 
from users) sub
group by group_id, groups;

 group_id | min_id | count 
----------+--------+-------
        1 |      1 |     3
        3 |      6 |     1
        2 |      4 |     1
        1 |      5 |     1
```


