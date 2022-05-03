-- Questions – Write SQL queries to get data for following requirements:

use ipl;

-- 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.

select * from ipl_bidder_details;
select * from ipl_bidder_points;

select bp.bidder_id, round(sum(if(bd.bid_status = 'won',1,0)) / bp.no_of_matches*100,2) as win_percentage
from ipl_bidder_points bp inner join ipl_bidding_details bd
on bp.bidder_id = bd.bidder_id group by bd.bidder_id
order by round(sum(if(bd.bid_status = 'won',1,0)) / bp.no_of_matches * 100,2) desc;

-- 2.	Display the number of matches conducted at each stadium with stadium name, city from the database.

select s.stadium_name, s.city, count(ms.match_id) as no_of_matches
from ipl_stadium s inner join ipl_match_schedule ms
on s.stadium_id = ms.stadium_id
group by s.stadium_name;

-- 3.	In a given stadium, what is the percentage of wins by a team which has won the toss?

select s.stadium_name,(count(*)/100*100) as percentage_win
from ipl_match m inner join ipl_match_schedule ms on m.match_id = ms.match_id
inner join ipl_stadium s on ms.stadium_id = s.stadium_id
where toss_winner = match_winner group by s.stadium_id;    

-- 4.	Show the total bids along with bid team and team name.

select bd.bid_team, bd1.bidder_name, count(*) from ipl_bidding_details bd  
inner join ipl_bidder_details bd1 on bd.bidder_id = bd1.bidder_id group by bd.bid_team;

-- 5.	Show the team id who won the match as per the win details.

select * from ipl_match;

select if (team_id1=match_winner,team_id1,team_id2) as team_id_winner from ipl_match;

-- 6.	Display total matches played, total matches won and total matches lost by team along with its team name.

select ts.matches_played, ts.matches_won, ts.matches_lost, t.team_id, t.team_name
from ipl_team_standings ts inner join ipl_team t
on ts.team_id = t.team_id
group by t.team_id;

-- 7.	Display the bowlers for Mumbai Indians team.

select ip.player_role, ip1.player_name from ipl_team it 
inner join ipl_team_players ip on it.team_id = ip.team_id
inner join ipl_player ip1 on ip.player_id = ip1.player_id
where it.team_name = 'mumbai indians' and ip.player_role = 'bowler';

-- 8.	How many all-rounders are there in each team, Display the teams with more than 4 
-- all-rounder in descending order.

select it.team_name, count(*) as no_of_allrounders from ipl_team it 
inner join ipl_team_players ip on it.team_id = ip.team_id 
inner join ipl_player iip on ip.player_id = iip.player_id
where ip.player_role = 'all-rounder' group by it.team_name order by count(*) desc;




 

