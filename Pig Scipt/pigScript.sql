ratings = LOAD '/user/maria_dev/ml-100k/u.data' AS  (userID:int, movieID:int, rating:int, ratingTime:int);

metadata = LOAD 'user/maria_dev/ml-100k/u.item' USING PigStorage('|') AS (movieID:int, movieTitle:chararray, releaseDate:chararray, videoRelease:chararray, imdbLink:chararray);  

nameLookup = FOREACH metadata GENERATE movieID, movieTitle, ToUnixTime(ToDate(releaseDate,'dd-MMM-yyyy')) AS releaseTime;  

ratingsByMovie = GROUP ratings by movieID;

avgRatings = FOREACH ratingsByMovie GENERATE group as movieID, AVG(ratings.rating) as AvgRating;

fiveStarMovies = FILTER avgRatings BY avgRating>4;

fiveStarsWithData = JOIN fiveStarMovies by movieID, nameLookup by movieID; 

oldestFiveStar = ORDER fiveStarsWithData BY namelookup::releaseTime;

DUMP oldestFiveStar; 


-- (493,4.15,493,Thin Man, The (1934),-1136073600)
-- (604,4.012345679012346,604,It Happened One Night (1934),-1136073600)
-- (615,4.0508474576271185,615,39 Steps, The (1935),-1104537600)
-- (1203,4.0476190476190474,1203,Top Hat (1935),-1104537600)
-- (613,4.037037037037037,613,My Man Godfrey (1936),-1073001600)
-- (633,4.057971014492754,633,Christmas Carol, A (1938),-1009843200)
-- (136,4.123809523809523,136,Mr. Smith Goes to Washington (1939),-978307200)
-- (1122,5.0,1122,They Made Me a Criminal (1939),-978307200)
-- (132,4.0772357723577235,132,Wizard of Oz, The (1939),-978307200)
-- (524,4.021739130434782,524,Great Dictator, The (1940),-946771200)
-- (478,4.115384615384615,478,Philadelphia Story, The (1940),-946771200)
-- (484,4.2101449275362315,484,Maltese Falcon, The (1941),-915148800)
-- (134,4.292929292929293,134,Citizen Kane (1941),-915148800)
-- (483,4.45679012345679,483,Casablanca (1942),-883612800)
-- (611,4.1,611,Laura (1944),-820540800)
-- (659,4.078260869565217,659,Arsenic and Old Lace (1944),-820540800)
-- (525,4.027397260273973,525,Big Sleep, The (1946),-757382400)
-- (489,4.115384615384615,489,Notorious (1946),-757382400)
-- (496,4.121212121212121,496,It's a Wonderful Life (1946),-757382400)
-- (1064,4.25,1064,Crossfire (1947),-725846400)
-- (519,4.1,519,Treasure of the Sierra Madre, The (1948),-694310400)
-- (513,4.333333333333333,513,Third Man, The (1949),-662688000)
-- (488,4.2,488,Sunset Blvd. (1950),-631152000)
-- (606,4.045454545454546,606,All About Eve (1950),-631152000)
-- (498,4.184210526315789,498,African Queen, The (1951),-599616000)
-- (648,4.029850746268656,648,Quiet Man, The (1952),-568080000)
-- (661,4.1022727272727275,661,High Noon (1952),-568080000)
-- (487,4.102941176470588,487,Roman Holiday (1953),-536457600)
-- (603,4.3875598086124405,603,Rear Window (1954),-504921600)
-- (490,4.02,490,To Catch a Thief (1955),-473385600)
-- (641,4.212121212121212,641,Paths of Glory (1957),-410227200)
-- (178,4.344,178,12 Angry Men (1957),-410227200)
-- (966,4.1923076923076925,966,Affair to Remember, An (1957),-410227200)
-- (199,4.175757575757576,199,Bridge on the River Kwai, The (1957),-410227200)
-- (479,4.251396648044692,479,Vertigo (1958),-378691200)
-- (480,4.284916201117318,480,North by Northwest (1959),-347155200)
-- (185,4.100418410041841,185,Psycho (1960),-315619200)
-- (1125,4.25,1125,Innocents, The (1961),-283996800)
-- (427,4.292237442922374,427,To Kill a Mockingbird (1962),-252460800)
-- (657,4.259541984732825,657,Manchurian Candidate, The (1962),-252460800)
-- (511,4.23121387283237,511,Lawrence of Arabia (1962),-252460800)
-- (474,4.252577319587629,474,Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb (1963),-220924800)
-- (520,4.104838709677419,520,Great Escape, The (1963),-220924800)
-- (197,4.104602510460251,197,Graduate, The (1967),-94694400)
-- (589,4.023255813953488,589,Wild Bunch, The (1969),-31536000)
-- (127,4.283292978208232,127,Godfather, The (1972),63072000)
-- (194,4.058091286307054,194,Sting, The (1973),94694400)
-- (654,4.136054421768708,654,Chinatown (1974),126230400)
-- (168,4.0664556962025316,168,Monty Python and the Holy Grail (1974),126230400)
-- (187,4.186602870813397,187,Godfather: Part II, The (1974),126230400)
-- (357,4.291666666666667,357,One Flew Over the Cuckoo's Nest (1975),157766400)
-- (530,4.025,530,Man Who Would Be King, The (1975),157766400)
-- (50,4.3584905660377355,50,Star Wars (1977),220924800)
-- (183,4.034364261168385,183,Alien (1979),283996800)
-- (180,4.04524886877828,180,Apocalypse Now (1979),283996800)
-- (192,4.120689655172414,192,Raging Bull (1980),315532800)
-- (172,4.204359673024523,172,Empire Strikes Back, The (1980),315532800)
-- (174,4.252380952380952,174,Raiders of the Lost Ark (1981),347155200)
-- (527,4.02051282051282,527,Gandhi (1982),378691200)
-- (89,4.138181818181818,89,Blade Runner (1982),378691200)
-- (528,4.132231404958677,528,Killing Fields, The (1984),441763200)
-- (191,4.163043478260869,191,Amadeus (1984),441763200)
-- (647,4.1,647,Ran (1985),473385600)
-- (165,4.109375,165,Jean de Florette (1986),504921600)
-- (166,4.120689655172414,166,Manon of the Spring (Manon des sources) (1986),504921600)
-- (173,4.172839506172839,173,Princess Bride, The (1987),536457600)
-- (170,4.1735537190082646,170,Cinema Paradiso (1988),567993600)
-- (190,4.137096774193548,190,Henry V (1989),599616000)
-- (651,4.076023391812866,651,Glory (1989),599616000)
-- (198,4.0078740157480315,198,Nikita (La Femme Nikita) (1990),631152000)
-- (98,4.28974358974359,98,Silence of the Lambs, The (1991),662688000)
-- (923,4.155172413793103,923,Raise the Red Lantern (1991),662688000)
-- (96,4.0067796610169495,96,Terminator 2: Judgment Day (1991),662688000)
-- (189,4.106060606060606,189,Grand Day Out, A (1992),694224000)
-- (709,4.028846153846154,709,Strictly Ballroom (1992),694224000)
-- (60,4.015625,60,Three Colors: Blue (1993),725846400)
-- (79,4.044642857142857,79,Fugitive, The (1993),725846400)
-- (1467,5.0,1467,Saint of Fort Washington, The (1993),725846400)
-- (169,4.466101694915254,169,Wrong Trousers, The (1993),725846400)
-- (963,4.2926829268292686,963,Some Folks Call It a Sling Blade (1993),725846400)
-- (318,4.466442953020135,318,Schindler's List (1993),725846400)
-- (83,4.0625,83,Much Ado About Nothing (1993),725846400)
-- (1194,4.064516129032258,1194,Once Were Warriors (1994),757382400)
-- (119,4.5,119,Maya Lin: A Strong Clear Vision (1994),757382400)
-- (1367,4.2,1367,Faust (1994),757382400)
-- (64,4.445229681978798,64,Shawshank Redemption, The (1994),757382400)
-- (814,5.0,814,Great Day in Harlem, A (1994),757382400)
-- (59,4.0602409638554215,59,Three Colors: Red (1994),757382400)
-- (56,4.060913705583756,56,Pulp Fiction (1994),757382400)
-- (48,4.094017094017094,48,Hoop Dreams (1994),757382400)
-- (45,4.05,45,Eat Drink Man Woman (1994),757382400)
-- (1169,4.1,1169,Fresh (1994),757382400)
-- (275,4.0111940298507465,275,Sense and Sensibility (1995),788918400)
-- (12,4.385767790262173,12,Usual Suspects, The (1995),808358400)
-- (694,4.045454545454546,694,Persuasion (1995),811987200)
-- (22,4.151515151515151,22,Braveheart (1995),824428800)
-- (23,4.1208791208791204,23,Taxi Driver (1976),824428800)
-- (1449,4.625,1449,Pather Panchali (1955),827452800)
-- (1201,5.0,1201,Marlene Dietrich: Shadow and Light (1996) ,828403200)
-- (114,4.447761194029851,114,Wallace & Gromit: The Best of Aardman Animation (1996),828662400)
-- (113,4.111111111111111,113,Horseman on the Roof, The (Hussard sur le toit, Le) (1995),829872000)
-- (408,4.491071428571429,408,Close Shave, A (1995),830649600)
-- (1599,5.0,1599,Someone Else's America (1995),831686400)
-- (1524,4.25,1524,Kaspar Hauser (1993),834105600)
-- (124,4.053475935828877,124,Lone Star (1996),835315200)
-- (1536,5.0,1536,Aiqing wansui (1994),837993600)
-- (1396,4.2,1396,Stonewall (1995),838339200)
-- (1653,5.0,1653,Entertaining Angels: The Dorothy Day Story (1996),843782400)
-- (285,4.265432098765432,285,Secrets & Lies (1996),844387200)
-- (1500,5.0,1500,Santa with Muscles (1996),847411200)
-- (1398,4.5,1398,Anna (1996),847843200)
-- (223,4.198529411764706,223,Sling Blade (1996),848620800)
-- (1639,4.333333333333333,1639,Bitter Sugar (Azucar Amargo) (1996),848620800)
-- (320,4.05,320,Paradise Lost: The Child Murders at Robin Hood Hills (1996),849830400)
-- (1642,4.5,1642,Some Mother's Son (1996),851644800)
-- (313,4.2457142857142856,313,Titanic (1997),852076800)
-- (272,4.262626262626263,272,Good Will Hunting (1997),852076800)
-- (302,4.161616161616162,302,L.A. Confidential (1997),852076800)
-- (1039,4.011111111111111,1039,Hamlet (1996),854064000)
-- (1189,5.0,1189,Prefontaine (1997),854064000)
-- (1007,4.127659574468085,1007,Waiting for Guffman (1996),854668800)
-- (1142,4.045454545454546,1142,When We Were Kings (1996),855878400)
-- (100,4.155511811023622,100,Fargo (1996),855878400)
-- (181,4.007889546351085,181,Return of the Jedi (1983),858297600)
-- (515,4.203980099502488,515,Boot, Das (1981),860112000)
-- (1251,4.125,1251,A Chef in Love (1996),861926400)
-- (251,4.260869565217392,251,Shall We Dance? (1996),868579200)
-- (316,4.196428571428571,316,As Good As It Gets (1997),882835200)
-- (1293,5.0,1293,Star Kid (1997),884908800)
-- (1191,4.333333333333333,1191,Letter From Death Row, A (1998),886291200)
-- (1594,4.5,1594,Everest (1998),889488000)
-- (315,4.1,315,Apt Pupil (1998),909100800)