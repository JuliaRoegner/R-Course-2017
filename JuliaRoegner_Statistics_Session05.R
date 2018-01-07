## Dataframe
Wortart <- c('ADJ', 'ADV', 'N', 'KONJ', 'PRAEP')
TokenFrequenz <- c(421, 337, 1311, 458, 455)
TypenFrequenz <- c(271, 103,735,  18, 37)
Klasse <- c('offen', 'offen', 'offen', 'geschlossen', 'geschlossen')

df1 <- data.frame(Wortart, TokenFrequenz, TypenFrequenz, Klasse)

write.table(df1, file = 'df1.csv', sep = '\t')


## Dataframes einlesen
df2 <-  read.table(file = 'df1.csv')


## Elemente ansprechen
df2$TokenFrequenz
attach(df2)
TokenFrequenz


## Sortierung und Selektion
v12 <- 1:100                  # seq(1, 100, 1)
v13 <- c(1, 4, 5, 3, 6, 9)
sort(v13)
sort(v13, TRUE)
order(v13)

v14 <- 1:100
v15 <- seq(1, 100)
v16 <- vector(mode = 'numeric', 100)
v17 <- seq_along(v16)
v17

df2[order(df2$TokenFrequenz), ]  
         ## Tabelle nach TokenFrequenz geordnet


## Samples
set.seed(1)
df2[sample(length(df2$Klasse)), ]
df2[sample(length(df2$Klasse)), ]


## Logische Abfragen
subset(df2, df2$Klasse == 'offen' & df2$TokenFrequenz > 100)
subset(df2, df2$Klasse == 'geschlossen' & df2$Wortart %in% c('KONJ', 'PRAEP'))



## Arbeit mit XML-Dateien
# Wir lesen XML-Dateien aus dem TÃ¼ba-D/Z-Korpus ein und extrahieren *Lemmata* und laufende *Wortformen*:

library(XML)

tokens <- vector('character')
types <- vector('character')

xmlEventParse(
  "C:/Users/Julia/Documents/GitHub/R-Course-2017/data/t_990505_47.xml", 
  handlers = list(
    't' = function(name, attr) {
      tokens <<- c(tokens, attr['word'])
      types <<- c(types, attr['lemma'])
      ## morphology
    }
  ),
  addContext = FALSE
)

#names(tokens) <- NULL
tokens <- unname(tokens)



## Aufgaben fÃ¼r die selbsstÃ¤ndige Arbeit

## 1. Einen Dataframe mit dem Wort, Lemma und Wortart anlegen

pos <- vector('character')

xmlEventParse(
  "C:/Users/Julia/Documents/GitHub/R-Course-2017/data/t_990505_47.xml", 
  handlers = list(
    't' = function(name, attr) {
      pos <<- c(pos, attr['pos'])
    }
  ),
  addContext = FALSE
)

dzCorpus <- data.frame(tokens, types, pos, stringsAsFactors = FALSE)


## 2. Daten alphabetisch nach dem Wort sortieren und in eine Datei speichern.

names (dzCorpus) [names(dzCorpus) == "tokens"] <- "Wort"
names (dzCorpus) [names(dzCorpus) == "types"] <- "Lemma"
names (dzCorpus) [names(dzCorpus) == "pos"] <- "Wortart"

write.table(dzCorpus[order(dzCorpus$Wort),], file = 'tuebaDZCorpus.csv', sep = '\t')


## 3. Durchschnittliche Länge der Substantive in Buchstaben berechnen

substantiv <- subset(dzCorpus, dzCorpus$Wortart == 'NN')
lengthSubs <- vector (mode = "integer", length = length(substantiv$Wort))

x <- 1
while (x <= length(substantiv$Wort)) {
  lengthSubs[x] <- nchar(substantiv[x,1])
  x <- x + 1
}
  
mean(lengthSubs)  ## 8.424779
         ## Ein Substantiv ist durchschnittlich etwa 8 Buchstaben lang.


## 5. Anzahl der autosemantischen Wörter im Text
## 'ADJA', 'ADJD', 'ADV', 'NN', 'NE', 'VAFIN', 'VAIMP', 'VAPP', 'VMINF', 'VMPP', 'VVFIN', 'VVIMP', 'VVINF', 'VVIZU', 'VVPP'

autosemantika <- subset(dzCorpus, dzCorpus$Wortart %in% c('ADJA', 'ADJD', 'ADV', 'NN', 'NE', 'VAFIN', 'VAIMP', 'VAPP', 'VMINF', 'VMPP', 'VVFIN', 'VVIMP', 'VVINF', 'VVIZU', 'VVPP'))
length(autosemantika$Wort)
         ## Es gibt 307 autosemantische Wörter im Text


## 4. Den Dataframe anpassen und die Verteilung von Substantiven nach dem Genus berechnen

morphology <- vector('character')

xmlEventParse(
  "C:/Users/Julia/Documents/GitHub/R-Course-2017/data/t_990505_47.xml", 
  handlers = list(
    't' = function(name, attr) {
      morphology <<- c(morphology, attr['morph'])
    }
  ),
  addContext = FALSE
)

dzCorpus$Morphologie = morphology

substantiv <- subset(dzCorpus, dzCorpus$Wortart == 'NN')
male <- subset(substantiv, substantiv$Morphologie %in% c('apm', 'asm', 'dpm', 'dsm', 'gpm', 'gsm', 'npm', 'nsm'))
female <- subset(substantiv, substantiv$Morphologie %in% c('apf', 'asf', 'dpf', 'dsf', 'gpf', 'gsf', 'npf', 'nsf'))
neuter <- subset(substantiv, substantiv$Morphologie %in% c('apn', 'asn', 'dpn', 'dsn', 'gpn', 'gsn', 'npn', 'nsn'))
withoutGender <- subset(substantiv, substantiv$Morphologie %in% c('ap*', 'dp*', 'gp*', 'np*'))

gender <- c('maskulin', 'feminin', 'neutrum', 'Geschlecht nicht eindeutig')
number <- c(length(male$Wort), length(female$Wort), length(neuter$Wort), length(withoutGender$Wort))

substantivGender <- data.frame(gender, number)

