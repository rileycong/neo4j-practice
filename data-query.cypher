// All nodes //
MATCH (n) RETURN n;

MATCH (player:PLAYER) RETURN player;

// Properies //
MATCH (player:PLAYER) RETURN player.name, player.height;

// Nodes where name is LeBron James //
MATCH (player:PLAYER) 
WHERE player.name = "LeBron James"
RETURN player;

// Nodes where name is LeBron James //
MATCH (player:PLAYER {name: "LeBron James"}) 
RETURN player;

// Nodes where name is not LeBron James
MATCH (player:PLAYER) 
WHERE player.name <> "LeBron James"
RETURN player;

// Nodes where height is greater than or equal to 2
MATCH (player:PLAYER) 
WHERE player.height >= 2
RETURN player;

// Nodes with a BMI not larger than 25
MATCH (player:PLAYER) 
WHERE NOT (player.weight / (player.height * player.height)) > 25
RETURN player;

// Orderby
MATCH (player:PLAYER) 
WHERE player.height >= 2
SKIP 1
RETURN player
ORDER BY player.height DESC
LIMIT 3;

// GET ALL LAKERS PLAYERS //
MATCH (player:PLAYER) - [:PLAYS_FOR] -> (team:TEAM)
WHERE team.name = "LA Lakers"
RETURN player, team;

// GET ALL PLAYERS THAT MAKE MORE THE 35M //
MATCH (player:PLAYER) - [contract :PLAYS_FOR] -> (team:TEAM)
WHERE contract.salary >= 35000000
RETURN player;

// GET ALL OF LEBRON'S TEAMMATES THAT MAKE MORE THAN 40M //
MATCH (lebron:PLAYER {name: "LeBron James"}) - [:TEAMMATES] -> (teammate:PLAYER)
MATCH (teammate) - [contract:PLAYS_FOR] -> (:TEAM)
WHERE contract.salary >= 40000000
RETURN teammate;

// GET HIGHEST SCORING PLAYER IN THE LAKERS //
MATCH (player:PLAYER) - [:PLAYS_FOR] - (:TEAM {name: "LA Lakers"})
MATCH (player) - [gamePlayed:PLAYED_AGAINST] - (:TEAM)
RETURN player.name, AVG(gamePlayed.points) AS ppg
ORDER BY ppg DESC
LIMIT 1;

