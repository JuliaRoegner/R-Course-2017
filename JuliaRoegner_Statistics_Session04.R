
## 2.1 DataFrame anlegen
Wortart <- c('ADJ', 'ADV', 'N', 'KONJ', 'PRAEP')
TokenFrequenz <- c(421, 337, 1411, 458, 455)
TypenFrequenz <- c(271, 103, 735, 18, 37)
Klasse <- c('offen', 'offen', 'offen', 'geschlossen', 'geschlossen')

x <- data.frame (Wortart, TokenFrequenz, TypenFrequenz, Klasse)
str(X)
x <- data.frame (Wortart, TokenFrequenz, TypenFrequenz, Klasse, row.names = Wortart)


## 2.2 DataFrame speichern
write.table(x, file ='dfx.csv', sep='\t')


## 2.3 DataFrame einlesen
x <- read.table(file='dfx.csv', header=(TRUE|FALSE), row.names=1)

## 2.4 Elemente Ansprechen
x$TokenFrequenz               ## [421 337 1411 458 455]
x$Klasse                      ## [offen offen offen geschlossen geschlossen]

attach(x)
TokenFrequenz
Klasse

x[2,3]                        ## [103]
x[2,]                         ## [ADV ADV 337 103 offen]
x[,3]                         ## [271 103 735 18 37]
x[2]                          ## 2. Spalte der Tabelle (TokenFrquenz)

x[2:3, 3:4]                   ## Als Ausgabe erfolgen die Daten der Felder [2,3], [3,3], [2,4], [3, 4]


## 2.5 Konditionale Abfragen
x$Klasse == 'offen'           ## [TRUE TRUE TRUE FALSE FALSE]
x[x$Klasse == 'offen',]       ## Ausgabe der Zeilen, für bei denen die Klasse offen ist

x[x[,4] == 'offen',]          ## Ausgabe der Zeilen, bei denen der Wert in der 4. Spalte "offen" ist

x[x$Klasse == 'offen',][x$TypenFrequenz > 150,]
          ## Ausgabe der Zeilen, bei denen die Klasse 'offen' ist und die TypenFrequenz bei mindestens '151' liegt

x[x$Klasse == 'offen',][x$TypenFrequenz < 500,]
x[x$Klasse == 'geschlossen',][x$TypenFrequenz > 100,]

x[,3][which(x[,2] > 450)]     ## Die TypenFrequenz, bei denen die dazugehörige TokenFreqeunenz größer als 450 ist.
                              ## [735 18 37]



## 2.6 subset
subset(x, x$Klasse == 'geschlossen')
         ## Konj & Praep

subset(x, x$Klasse == 'offen' & x$TypenFrequenz < 100)
         ## für keine Kategorie zutreffend (Leeres Ergebnis):
         ## [1] Wortart       TokenFrequenz TypenFrequenz Klasse       
         ## <0 Zeilen> (oder row.names mit Länge 0)

subset(x, x$Klasse == 'offen' & x$TypenFrequenz < 200)
         ## Adv

subset(x, x$Klasse == 'offen' | x$Wortart == 'KONJ')
         ## alle Zeilen bis einschließlich Konj. (Adj, Adv, N, Konj)

# unzulässig
subset(x, x$Klasse == 'offen' | x$Wortart == ('KONJ' | 'PRAEP'))
         ## operations are possible only for numeric, logical or complex types
subset(x, x$Klasse == 'offen' | x$Wortart %in% c('KONJ', 'PRAEP'))
         ## Ausgabe der offenen Klassen und bei denen, die eine Konjunktion oder Präposition sind
subset(x, x$Wortart %in% c('N', 'ADJ'))
         ## Ausgabe derjenigen, die Nomen oder Adjektiv



## 2.7 fix(): Eingebauter Editor
fix(x)                        ## ???? ????????, ?????? ?????? ?????? ???????????? ??????????
         ## Ein formatierte Tabelle wird ausgegben



## 2.8 Sortieren
vec <- c(1,5,2,3)
sort(vec)                     # => [1] 1 2 3 5
order(vec)                    # => [1] 1 3 4 2 (Permutation)

# `?order`
x[order(x$TypenFrequenz),]    ## Tabelle aufsteigend nach TypenFrequenz sortiert
x[order(-x$TypenFrequenz),]   ## Tabelle absteigend nach TypenFrequenz



2.9
x[sample(length(x$Klasse)),]  # ?????????????????????? ?????????????????? ??????
         ## Zufällige Sortierung der Tabelle
