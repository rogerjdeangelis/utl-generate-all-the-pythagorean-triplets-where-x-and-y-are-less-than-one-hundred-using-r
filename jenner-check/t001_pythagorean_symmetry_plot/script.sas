/*----                                                                   ----*/
/*---- Pythagorean triples: the 16 primitive+scaled triples with x,y<100  ----*/
/*---- These are the COL_0/COL_1/COL_2 rows the R step writes to SD1.TRIPS ----*/
/*---- (documented in the repo as "SD1.TRIPS total obs=63", first 16 obs). ----*/
/*---- Here they seed WORK.TRIPS so the pure-SAS core runs standalone.     ----*/
/*----                                                                   ----*/

data trips;
  input col_0 col_1 col_2;
datalines;
3 4 5
5 12 13
15 8 17
7 24 25
21 20 29
35 12 37
9 40 41
45 28 53
11 60 61
33 56 65
63 16 65
55 48 73
13 84 85
77 36 85
39 80 89
65 72 97
;
run;quit;

/*----                                                                   ----*/
/*---- Take advantage of symmetry and interchange x col_1 col_2          ----*/
/*----                                                                   ----*/

data want(keep=x y z pair);
  length pair $12;
  set trips;
  x=col_0;
  y=col_1;
  z=col_2;
  pair=catx(',',x,y,z);
  output;
  y=col_0;
  x=col_1;
  pair=catx(',',x,y,z);
  output;
run;quit;

options ls=94 ps=64;
proc plot data=want;
 plot x*y='*' $ pair   / box overlay;
run;quit;
