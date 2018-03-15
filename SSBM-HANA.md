---
title: "SSMB Benchmark für SAP HANA"
author: [Jan Hofmeier, Marius Jochheim, Lion Scherer, Kristina Albrecht]
date: 2018-03-06
subject: "Hana"
tags: [Hana, SSBM]
subtitle: "Datenbanken"
titlepage: true
titlepage-color: 06386e
titlepage-text-color: FFFFFF
titlepage-rule-color: FFFFFF
titlepage-rule-height: 1
...

# SAP HANA

# Generell HANA als in-memory Datenbank

SAP Hana (Die High Performance Analytic Appliance) ist eine Entwicklungsplattform und bestehtim Kern aus einer „in-memory“ Datenbank.

Transaktionen und Analysen werden aufeiner einzigen, singulären Datenkopie im Hauptspeicher verarbeitet, anstatt dieFestplatte als Datenspeicher zu benutzen. Dadurch ist es möglich sehr komplexeAbfragen und Datenbankoperationen mit sehr hohen Durchsatz auszuführen.

Hana verbindet OLTP, durch die SQL undACID (Atomicity, Consistency, Isolation andDurability) Kompatibilität, und OLAP durch das „in-memory“ feature.Durch das ACID Prinzips ist die Datenbank geeignet um Unternehmensinterne Datenzu speichern. Es ist nicht nötig Datenanalysen über einen ETL Prozess an einDatawarehouse weiterzuleiten. Komplexe Echtzeit Analysen [[1\]](#_ftn1)könnennun direkt durch SAP Hana durchgeführt werden. Das erspart die erheblichenKosten und vor allem Zeit.

Beim der „in-memory“ Technologie werdendie Daten im Hauptspeicher anstatt auf elektromagnetischen Festplattengespeichert. Antwortzeiten und Auswertungen können dadurch schneller als beigewöhnlichen Festplatten durch den Prozessor vorgenommen werden. Dadurch, dassder Zugriff auf die Festplatte nun wegfällt, verkürzt sich dieDatenzugriffszeit bis auf das Fünffache. 

![img](file:///C:/Users/IBM_ADMIN/AppData/Local/Temp/OICE_16_974FA576_32C1D314_1CA5/msohtmlclip1/01/clip_image001.png)

 

<https://intellipaat.com/blog/what-is-sap-hana/> 

Um nun aber dem „D“ des ACID Prinzips gerechtzu werden reicht eine Speicherung im füchtigen Hauptspeicher nicht. Für die Datensicherungmüssen deshalb traditionelle Festplatten benutzt werden. Diese werden bei derreinen Analyse von Daten nicht berücksichtigt. Wenn Transaktionen getätigtwerden, müssen die regelmäßig an das nicht flüchtige Speichermedium übergebenwerden. Außerdem wird dort zu jeder Transaktion ein Protokolleintraghinterlegt.

------

[[1\]](#_ftnref1)https://intellipaat.com/interview-question/sap-hana-interview-questions/

2<https://link.springer.com.ezproxy.dhbw-mannheim.de/book/10.1007%2F978-3-658-18603-6>

3<https://www.sap.com/germany/products/hana.html#pdf-asset=2caaec36-847c-0010-82c7-eda71af511fa&page=3>

 

# Row-Column based / Indizes

Die Daten werden in der SAP Hana Datenbank in zwei verschiedenen Formaten abgelegt. Hierbei handelt es sich um die spalten- und zeilenorientierte Speicherung.  Sollen beispielsweise transaktionale Prozesse (OLTP) durchgeführt werden, bietet sich die Verwendung der zeilenorientierten Speicherung an, da das Aktualisieren und Hinzufügen der Daten durch die Zeilen Anordnung vereinfacht wird. 
Für Lesezugriffe ist diese Art der Speicherung nicht geeignet, da jede Zeile gelesen werden muss, was sehr unperformant ist. Es müssten Daten gelesen werden, die für die bestimmte Abfrage nicht von Relevanz sind. Daher werden Lesezugriffe und Analyseabfragen auf die spaltenorientierte Speicherung ausgeführt und somit wird nur auf die relevanten Daten zugegriffen. Dies hat eine enorme Performance zur Folge.
Durch die spaltenorientierte Speicherung erreicht man neben der Zugriffsbeschleunigung auch eine höhere Kompression der Daten. Die Daten können gut komprimiert werden, da Tabellenspalten häufig gleiche Werte enthalten. 
 

Die Anzahl der Indizes kann erheblich reduziert werden. Bei der spaltenorientierten Speicherung kann jedes Attribut als Index verwendet werden. Da jedoch die gesamten Daten im Speicher vorhanden sind und die Daten einer Spalte alle aufeinanderfolgend gespeichert sind ist die Geschwindigkeit eines vollen sequentiellen Scans eines Attributs ausreichend in den meisten Fällen. Falls es nicht schnell genug ist können zusätzlich Indizes benutzt werden.

# Komprimierungen und Referenzen

Warum Komprimierung?
Daten eignen sich. / CPU aufwand?
Bei der spaltenorientierten Speicherung ist es möglich Daten zu Komprimieren. Dadurch wird Speicherplatz gespart und Zugriffszeiten verringert. Es gibt zwei mögliche Komprimierungen:
• Dictonary compression: 
Diese Methode wird auf alle Spalten angewandt. Alle verschiedenen Spaltenwerte werden aufeinanderfolgenden Zahlen zugeordnet. Anstatt nun die verschiedenen Werte zu speichern werden stattdessen die viel kleiner Zahlen gespeichert. Dadurch wird die Zahl der Datenzugriffe minimiert und es gibt weniger Cache Fehler, da mehrere Informationen in einer Cache-Line vorhanden sind. Außerdem ist es möglich Operationen direkt auf die komprimierten Daten auszuführen.
• Advanced compression:
Die einzelnen Zeilen selbst können durch verschiedene Komprimierungsmethoden weiter verkleinert werden. Dazu gehören: 
o prefix encoding:
Spalte enthält eine dominante Value / andere Values selten
	ein Wert wird sehr oft unkomprimiert gespeichert
datenset muss sortiert werden nach der Spalte mit der dominanten Value & der Attribut Vektor muss mit dem dominanten starten.
Zur Komprimierung sollte die dominante Value nicht jedes mal explizit gespeichert werden wenn sie auftritt. 
	Speichern der Nummer der Auftretungen der dominanten Value und eine Instanz der Value selbst im Attribut Vektor.
Prefix encoded Attribut Vektor enthält folgende Informationen:
	Nummer der Auftretungen der dominanten Value 
	valueID der dominanten Value aus dem Dictonary
	valueIDs der fehlenden Values
 

o run length encoding:
Gut wenn ein Paar Werte mit hohem Aufkommen
Sollte nach Werten sortiert sein für eine maximale Komprimierung
Anstatt alle Werte einer Spalte zu Speichern werden lediglich 2 Vektoren gespeichert.
Einer mit allen verschiedenen Values
Einer mit der Startposition der Value 
 

o cluster encoding:
Ist gut wenn eine Spalte viele identische Werte hat die hinternander stehen.
Attribut Vektor is partitioniert in n Blöcke mit fester Größe (tipischerweise 1024 Elements)
Wenn ein Cluster nur einen Wert hat wird er durch eine 1 ersetzt.
Wurde er nicht ersetzt steht dort eine 0.
 
o sparse encoding: 
o inderict encoding:
Ist gut wenn verschiedene Values oft vorkommen  BSP: bei zusammenhängenden Spalten. Nach Land Sortiert und auf Namensspalte zugreifen
Wie bei Cluster encoding  N Datenblöcke mit fester Anzahl Elementen (1024)
 

Die SAP Hana Datenbank benutzt Algorithmen um zu entscheiden, welche der Komprimierungsmethoden am angebrachtesten für die verschiedenen Spalten ist.
Bei jeder „delta merge“ Operation wird die Datenkompression automatisch evaluiert, optimiert und ausgeführt. 




- In-Memory Datenbank
- Column-Based Architektur
- Komprimierung
- Memory Zugrigge

# Star Schema Benchmark (SSBM)
<!-- Star Schema Benchmark (https://www.cs.umb.edu/~poneil/StarSchemaB.PDF) als Quelle einfügen und einarbeiten (Vergleiche Quelle 9)-->

<!-- Quelle zu TPC-H Benchmark: www.tpc.org/tpch/ (Vergleiche Quelle 14)-->

<!-- Quelle 1 Anfang: [Adjoined Dimension Column Index (ADC Index) to Improve Star Schema Query Performance](https://www.cs.umb.edu/~xuedchen/research/publications/SSBPaperICDE08_7_full_paper.doc) -->

Der Star Schema Benchmark (SSB) wurde von Pat O'Neil, Betty O'Neil und Quedong Chen entwickelt, um die Performance von Datenbanksystemen, welche mit Data-Marts nach dem Star Schema arbeiten, zu ermitteln und Vergleichbar zu machen [Star Schema Benchmark Quelle]. Dabei nutzen sie das bekannte TPC-H Benchmark [TPCH Quelle] als Grundlage für ihr Star Schema Benchmark, modifizieren es jedoch vielfach zugunsten eines guten Star Schemas.

<!-- Hier kurz TPC-H aufgreifen und Abbildung einfügen für spätere Vergleiche -->

**TPC-H zu SSB-Transformation**

Die von Chen, O'Neil und O'Neil durchgeführten Transformationen von TPC-H zu SSB wurden an die von Kimball und Ross erläuterten Prinzipien zur Dimensionalen Modellierung [**The Data Warehouse Toolkit Second Edition - Quelle einfügen**] angelehnt. 

--- Hier SSB-M Schema Grafik einfügen ---

Im Folgenden sind die wichtigsten Änderungen kurz zusammengefasst:

1. Die beiden Tabellen LINEITEM und ORDER aus dem TPC-H Schema werden in SSB zu einer gemeinsamen Tabelle LINEORDER zusammengefasst, was als Denormalisierung bezeichnet wird [**The Data Warehouse Toolkit Seite 121 - Check**]. Dadurch werden für gängige Abfragen weniger Joins benötigt. Die Kardinalität der Tabelle entspricht der ursprünglichen LINEITEM Tabelle und beinhaltet einen replizierten ORDERKEY zur Verknüpfung der Tabellen.

2. Die Tabelle PARTSUPP aus dem TPC-H Schema wird nicht in das SSB übernommen, da die Granularität zwischen PARTSUPP und LINEORDER nicht übereinstimmt. Dies kommt daher, dass LINEORDER bei jeder Transaktion vergrößert wird, die PARTSUPP Tabelle jedoch nicht. Sie hat lediglich die Granularität Periodic Snapshot, da es keinen Transaction Key für sie gibt. Auch im TPC-H Schema gibt es keine Aktualisierungen über den Verlauf. Damit bleibt sie im Gegensatz zur LINEORDER Tabelle über den Zeitverlauf unverändert.

  Dies würde kein Problem darstellen, wenn PARTSUPP und LINEORDER durchgehend als getrennte Faktentabellen behandelt würden, welche nur getrennt abgefragt und nie zusammengefügt werden. Jedoch zeigt Abfrage Q9 aus dem TPC-H Schema, dass LINEITEM, ORDERS und PARTSUPP kombiniert werden, womit Konflikte entstehen.

  Die Autoren des SSB-M argumentieren, dass die PARTSUPP Tabelle im Kontext eines Data Marts unnötig ist, woraus die Löschung der Tabelle erfolgt. Stattdessen wird eine Spalte SUPPLYCOST aus der Tabelle zu jeder LINEORDER Zeile im neuen Schema hinzugefügt. Dadurch wird die Korrektheit der Information in Bezug zur Bestellzeit sicher gestellt.

  TODO: Für andere Transformationsdetails von TPC-H zu SSB verweisen wir den Leser auf [Star Schema Benchmark]. Beispielsweise werden die Spalten TPC-H SHIPDATE, RECEIPTDATE und RETURNFLAG gelöscht, da die Bestellinformationen vor dem Versand abgefragt werden müssen, und wir wollten uns nicht mit einer Folge von Faktentabellen befassen, wie in [Kimball, Ross], pg. 94. Außerdem hat TPC-H keine Spalten mit relativ kleinem Filterfaktor, daher fügen wir eine Anzahl von Rollup-Spalten hinzu, wie P_BRAND1 (mit 1000 Werten), S_CITY und C_CITY und so weiter.

  <!-- Quelle 1 Ende -->

- Warum SSBM? Für Dimensionale Modellierung, interessant für OLAP
- Unterschiede zu TPC-H ausarbeiten anhand SSB-M Schema, Quellen, Bilder
- Generierung von SSBM-Tabellen
- Tabellen in HANA laden

# SQL-Abfragen für SSBM
- Anpassung der TPC-H Queries auf SSBM
- Generierung von Abfragen mit Qgen

# Durchführung von Benchmarks 
### Aufsetzen von HANA: Installation, Beschreibung vom System (Prozessoren, RAM, OS, Festplattenspeicher etc.)
### Durchführung von Performance Tests und Auswertung der Query Execution Plans
- Row vs. Column Store
- Wie kann man durch Indizes oder Hints beschleunigen?
- Parallele Zugriffe (Concurrency, unter Umständen)


# Fragen
- Out of Memory Problem
- Zugriff auf HANA an der DH
- Gibt es Standard-Queries für SSBM? 
- Wie viele Queries? Skalierung?
- Welche Metriken sind bei dem Benchmark wichtig?
Laufzeit, (Systembelastung)
