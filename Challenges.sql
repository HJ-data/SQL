-- print the hacker_id, name, and the total number of challenges
-- sort total number desc, hacker_id asc
-- more than 2 students have same count(challenges) <->, less than 6 challange each, exclude.  --> ?????
-- if? case when?? or not in 



select h.hacker_id, h.name, sum(challenge_id)
from hackers h
join challenges c
on h.hacker_id  = c.hacker_id
where h.hacker_id not in (select hacker_id, challenge_id
                          from challenges
                          where count(challenge_id) = (select count(challenge_id)
                                                        from challenges
                                                        group by challenge_id)
                          and count(challenge_id) < 6)
group by c.challenge_id;




select H.hacker_id, H.name, count(C.challenge_id) as total 
from hackers as H
join challenges as C
on H.hacker_id = C.hacker_id
group by H.hacker_id, H.name
having total in (select C2.total
                 from (select hacker_id, count(challenge_id) as total
                       from challenges as C1
                       group by hacker_id) as C2
                 group by C2.total
                 having count(C2.total)=1)
    or total = (select max(C4.total)
               from (select hacker_id, count(challenge_id) as total
                     from challenges as C3
                     group by hacker_id) as C4)
order by total desc, H.hacker_id