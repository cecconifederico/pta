extensions [csv]


breed [articles article]
; Codice Articolo;Contenuto complottista;Intensita;Tema;Politicamente orientato;Orientamento politico;Incitamento odio;Incitamento paura;websites
; CT_1;1;5;CoronaFake;0;NA;1;0;web_65

breed [pages page]
; Id_pagina;Source;Followers;Date;Interactions;Post.Type;Link;V7;id_articolo
; pg_1;-  CIRCOLO  LA LOMBARDIA ATTIVA -;475;Thu Nov 05 2020 23:44:40 GMT+0000;2;Facebook;https://www.facebook.com/groups/1980248708868313/permalink/3212733052286533;128;CT_128

breed [websites website]
;"ID_web" "sum_of_interactions" "count_of_articles" "Colonna2" "Colonna1" "Colonna12" "fame_index" "exclusivity"]

breed [users user]
;

undirected-link-breed [arttowebs arttoweb]
undirected-link-breed [arttopags arttopag]
undirected-link-breed [usetopags usetopag]

articles-own [id_article contents intensity issue political political_orientation incitement_to_hate incitement_to_fear id_website]
pages-own [id_page source followers interactions id_article]
websites-own [id_web sum_of_interactions count_of_articles fi ex]
; c1 c2 c12 do not use
users-own [id_user comment id_page]

globals [articles_db pages_db websites_db users_db]



to run_simulation
;  ask pages [
;    actual-page one-of
;    try possible-article
;      link possible-article with web site
;          go/no go contents, intensity, political, ----
;          modify rank by vector issue
;     modify-rank by ->
;    sum of interactions somma delle interazioni (da pagina) di tutti gli articoli provenienti da quel sito web
;
;    fi
;    ex

;   if rank> th LINK PAGE TO ARTICLES


  ; compute_stats
  ; draw_all

end

to setup_simulation
  clear-all
  set articles_db (csv:from-file "dr02_eng_articles.csv" ";")
  set pages_db (csv:from-file "dr02_eng_pages.csv" ";")
  set websites_db (csv:from-file "dr02_eng_websites.csv" ";")
  set users_db (csv:from-file "dr02_eng_users.csv" ";")

  set pages_db but-first pages_db
  foreach pages_db [x ->
    create-pages 1[
      set id_page (item 0 x)
      set source (item 1 x)
      set followers (item 2 x)
      set interactions (item 4 x)
      set id_article (item 7 x)
      set shape "star"
      setxy  (abs random-xcor) * -1 (abs random-ycor)
      set size 0.4
      set color blue
    ]
  ]

  set users_db but-first users_db
  foreach users_db [x ->
    create-users 1[
      set id_user (item 0 x)
      set comment (item 1 x)
      set id_page (item 2 x)
      let mypage one-of pages with [id_page = (item 2 x)]
      create-usetopag-with mypage [if random-float 1 < 0.9 [set hidden? true]]
      set shape "person"
      setxy  (abs random-xcor) * -1 (abs random-ycor) * -1
      set size 0.6
      set color yellow
    ]
  ]


  set websites_db but-first websites_db
  foreach websites_db [x ->
    create-websites 1[
      set id_web (item 0 x)
      set sum_of_interactions (item 1 x)
      set count_of_articles (item 2 x)
      set fi (item 6 x)
      set ex (item 7 x)
      set shape "house"
      setxy  (abs random-xcor) (abs random-ycor) * -1
      set size 0.9
      set color blue
    ]
  ]

  ;  [id_article contents intensity issue political political_orientation incitement_to_hate incitement_to_fear id_website]
  set articles_db but-first articles_db
  foreach articles_db [x ->
    create-articles 1[
      set id_article (item 0 x)
      set contents (item 1 x)
      set intensity (item 2 x)
      set issue (item 3 x)
      set political (item 4 x)
      set political_orientation (item 5 x)
      set incitement_to_hate (item 6 x)
      set incitement_to_fear (item 7 x)
      set id_website (item 8 x)
      let mywebsite one-of websites with [ID_web = (item 8 x)]
      create-arttoweb-with mywebsite
      set shape "square"
      setxy  (abs random-xcor) (abs random-ycor)
      set size 0.6
      set color green
    ]
  ]


end
@#$#@#$#@
GRAPHICS-WINDOW
174
22
948
797
-1
-1
12.56
1
10
1
1
1
0
0
0
1
-30
30
-30
30
0
0
1
ticks
30.0

BUTTON
14
25
126
59
NIL
run_simulation
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
14
64
126
98
NIL
run_simulation
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
14
105
139
139
NIL
setup_simulation
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
13
158
168
203
modality
modality
"Random setup" "From survey setup"
0

CHOOSER
14
208
169
253
Scenarios
Scenarios
"From interface" "Choosey" "Loose"
0

SWITCH
962
34
1150
67
article_contents_weigth
article_contents_weigth
1
1
-1000

SWITCH
963
70
1150
103
article_intensity_weigth
article_intensity_weigth
1
1
-1000

CHOOSER
963
107
1119
152
article_issue_schema
article_issue_schema
"default" "political" "extremist" "moderate"
0

CHOOSER
965
157
1119
202
article_political_schema
article_political_schema
"neutral" "1 R" "-1 R" "1 L" "-1 L"
3

CHOOSER
965
206
1135
251
article_incitement_schema
article_incitement_schema
1 2 3 4 5
0

CHOOSER
962
313
1100
358
websites_schema
websites_schema
1 2 3 4 5
0

MONITOR
967
255
1054
300
NIL
count articles
17
1
11

MONITOR
963
362
1059
407
NIL
count websites
17
1
11

CHOOSER
1183
34
1321
79
pages_schema
pages_schema
1 2 3 4 5
0

MONITOR
1184
88
1265
133
NIL
count pages
17
1
11

MONITOR
1184
140
1262
185
NIL
count users
17
1
11

PLOT
1188
200
1388
350
Page To Articles LINKS
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot count arttopags"

@#$#@#$#@
## WHAT IS IT?

Setup
Carico il database relazionale
4 liste 
Websites_db
Articles_db
Page_db
Users_db

Creo 4 tipologie diversi di agenti:
Websites
Articles
Pages
Users
websites-own [id_website fame exclusivity]
articles-own [id_article contents from_website interactions]
pages-own [from_users to_articles dimension age]
users-own [activity]

Il numero degli agenti è uguale ai record del database
Le proprietà sono prese dal database
I campi che legano le pagine egli articoli sono vuoti (le pagine e gli articoli sono scollegati). La simulazione fa esattamente questo. Lega le pagine agli articolo

; fame, is an integer [1:10], 10 is the max
; exclusivity, is an integere [1:10], 10 is the max
; contents, is a list [content1, content2, ...]
; from_website, the index is id_website
; interactions, is an integer
; to articles, is a list [id_article1, id article2, ...]

Dettaglio agenti
Pagine
Id_pagina	Source	Followers	Date	Interactions	Post.Type	Link	V7	id_articolo
pg_1	-  CIRCOLO  LA LOMBARDIA ATTIVA -	475	Thu Nov 05 2020 23:44:40 GMT+0000	2	Facebook	https://www.facebook.com/groups/1980248708868313/permalink/3212733052286533	128	CT_128
pg_10	#IlMioVotoConta	4540	Thu Oct 15 2020 20:54:14 GMT+0000	0	Facebook	https://www.facebook.com/groups/552746508454213/permalink/1230242437371280	4	CT_4
pg_100	Amazing	95412	Thu Oct 29 2020 14:01:08 GMT+0000	1	Facebook	https://www.facebook.com/Fantasia20019/posts/3524733517588026	18	CT_18

Articoli
Titolo	Parole_codici	Categorie	Testata
“ACCENDI LA TV E NON SI SENTE PARLARE DI ALTRO CHE ‘COVID, COVID, COVID, COVID, COVID, COVID			web_9
“C’è un disegno planetario: imporranno un nuovo lockdown, ma non per ragioni virologiche” 			web_67

Websites
Name	ID_web	sum_of_interactions	count_of_articles	Colonna2	Colonna1	Colonna12	fame_index	exclusivity
AgenPress	web_1	131	1	6,800210859	0	3,40010543	3,40010543	3
Alessandria24.com	web_2	23	1	1,10701107	0	0,553505535	0,553505535	1
Ambiente Bio	web_3	35	2	1,739588824	4,166666667	2,953127746	2,953127746	5
Ansa	web_4	225	1	11,75540327	0	5,877701634	5,877701634	1

Users
ID_User	Comment	ID_Pages
ID: 100001360176159	Stanno morendo, purtroppo, le solite centinaia di persone con " normali " polmoniti stagionali. Il sistema spinge almeno l'80% delle persone a credere che il problema sia il coxxd19 .....in attesa del coxxid20   ????	pg_110
ID: 100004450984804	Grande Doctor	pg_110
ID: 1569651172	Riusciremo a smascherare l'inganno, con un po di pazienza si arriva alla verità. grazie Stefano Montanari. 	pg_110

RUN SIMULATION	
La simulazione dura fin quando tutti gli articoli sono collegati (pubblicati) su una pagina
Un articolo guarda suun sottoinsieme delle pagine a disposizione. Le pagine ‘assorbono’ parte delle proprietà che li caratterizzano dai siti web che li accolgono e dagli user che li popolano
Il motore che decide che un articolo ha trovato la sua pagina utilizza le sue informazioni sui contenuti (parole categorie)  dell’articolo tramite una tabella che contiene un relazione tipo: se il contenuto è X allora la pagina papabile è Y
Inoltre il motore utilizza le informazioni numeriche sulle pagine per aggiustare il punteggio generato dai contenuti semantici
Quando questo punteggio ha superato una soglia, allora l’artcolo è pubblicato. Questo modifica i punteggi sul numero di condivisioni
Ovviamente un articolo può fallire la sua ricerca. E così si passa ad un altro articolo. E cosi via
	







## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

;*, Jan Lorenz2,3 and Peter Holtz4
;
;1
;Institut f€ur Demokratie und Zivilgesellschaft (Institute for Democracy and Civil
;Society, IDZ), Jena, Germany
;2
;BIGSSS Bremen International Graduate School of Social Sciences, Jacobs University,
;Bremen, Germany
;3
;Department of Computational Social Science, GESIS Leibniz Institute for the Social
;Sciences, Cologne, Germany
;4
;Leibniz-Institut f€ur Wissensmedien IWM (Knowledge Media Research Center),
;T€ubingen, Germany
;
;
;  ]
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
