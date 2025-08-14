[x] 0. Wie speicher ich die db als File?
mysqldump -u chen -p datenbankname > name-vom-export.sql

[x] 1. Abteilung Tabelle erstellen +  Datasets
[x] 2. Raum Tabelle erstellen + Datasets

[x] 3.1  Arzt + 
[x] 3.2 Personal Tabellen + Datasets erstellen

[x] 4. Patient Tabelle + datasets
[x] 5. zu schluss Behandlung Tabelle + datasets

# Constraints

Constraints habe ich hauptsächlich darauf geachtet, 
dass alles was nicht null sein darf 'not null' besitzt,
alle IDs sind integer mit auto_increment. Ich habe daran
gedacht, den IDs den unique-constraint zu geben aber weil
ich die IDs als primary key markiere sorgt es schon dafür

# Trigger

Wenn ich einen Trigger erstellt habe, dann oftmals
2 Versionen, before insert und before update. Online
habe ich auf die Schnelle keine Syntax gefunden, die
es erlaubt before insert *und* before update in einem
einzelnen Trigger zu erwähnen

Im Behandlung Table habe ich Trigger erstellt,sie stellen 
sicher dass das Datum der Behandlung nicht außerhalb der 
Anwesenheit eines Patienten sein kann

Im Patient Table habe ich 2 Trigger erstellt um sicher
zu gehen dass das Aufnahmedatum vor dem Entlassungsdatum
liegt.

Trigger für Personal habe ich ausgelassen, ich hätte höchstens
für das Rollen Attribut einen Trigger erstellt aber da ich
für Rollen enums verwende, können eh nur vorherbestimmte
Werte dort benutzt werden

Für die restlichen Tabellen (Abteilung, Arzt, Raum habe ich
auch keinen Zweck für Trigger gesehen...

DELIMITER //
CREATE TRIGGER Behandlungsdatum_Neu
BEFORE INSERT ON Behandlung
FOR EACH ROW
BEGIN
    DECLARE aufnahme DATE;
    DECLARE entlassung DATE;

    SELECT Aufnahmedatum, Entlassungsdatum
    INTO aufnahme, entlassung
    FROM Patient
    WHERE PatientID = NEW.PatientID;

    IF entlassung IS NOT NULL AND NEW.Datum > entlassung THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Behandlungsdatum muss übereinstimmen mit den Aufenthaltszeiten des Patienten.';
    END IF;

    IF NEW.Datum < aufnahme THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Behandlungsdatum muss übereinstimmen mit den Aufenthaltszeiten des Patienten.';
    END IF;
END;
//

DELIMITER ;


DELIMITER //
CREATE TRIGGER Behandlungsdatum_Bearbeiten
BEFORE UPDATE ON Behandlung
FOR EACH ROW
BEGIN
    DECLARE aufnahme DATE;
    DECLARE entlassung DATE;

    SELECT Aufnahmedatum, Entlassungsdatum
    INTO aufnahme, entlassung
    FROM Patient
    WHERE PatientID = NEW.PatientID;

    IF entlassung IS NOT NULL AND NEW.Datum > entlassung THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Behandlungsdatum muss übereinstimmen mit den Aufenthaltszeiten des Patienten.';
    END IF;

    IF NEW.Datum < aufnahme THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Behandlungsdatum muss übereinstimmen mit den Aufenthaltszeiten des Patienten.';
    END IF;
END;
//

DELIMITER ;


DELIMITER //
CREATE TRIGGER Patientdatum_Neu
BEFORE INSERT ON Patient
FOR EACH ROW
BEGIN
    IF NEW.Entlassungsdatum IS NOT NULL AND NEW.Aufnahmedatum > NEW.Entlassungsdatum THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Aufnahmedatum darf nicht vor Entlassungsdatum stattfinden.';
    END IF;
END;
//


DELIMITER //
CREATE TRIGGER Patientdatum_Bearbeiten
BEFORE UPDATE ON Patient
FOR EACH ROW
BEGIN
    IF NEW.Entlassungsdatum IS NOT NULL AND NEW.Aufnahmedatum > NEW.Entlassungsdatum THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Aufnahmedatum darf nicht vor Entlassungsdatum stattfinden.';
    END IF;
END;
//

# Procedures

13. Überlegen Sie welche Datenabfragen im Betrieb des Krankenhauses sinnvoll sein könnten.
[x] Für die Rezeption wäre eine Abfrage gut, in der alle anwesenden Patienten aufgelistet
werden. 
[x] Zum Erstellen von Behandlungs Datasets wäre eine Abfrage nützlich, welche Ärzte die
Behandlung durchführen können (AbteilungID des Patienten muss gleich sein wie AbteilungID
des Arztes) + welche Räume dafür zur Verfügung stehen (liste alle Räume auf der AbteilungID
des Patienten/Arztes)

DELIMITER //
CREATE PROCEDURE Behandlungsoptionen_ByName(IN p_name VARCHAR(50))
BEGIN
    DECLARE patient_abteilung INT;

    SELECT AbteilungID
    INTO patient_abteilung
    FROM Patient
    WHERE Name = p_name
    LIMIT 1;

    SELECT ArztID, Name
    FROM Arzt
    WHERE AbteilungID = patient_abteilung;

    SELECT RaumID, Name
    FROM Raum
    WHERE AbteilungID = patient_abteilung;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE Behandlungsoptionen_ByID(IN p_id INT)
BEGIN
    DECLARE patient_abteilung INT;

    SELECT AbteilungID
    INTO patient_abteilung
    FROM Patient
    WHERE PatientID = p_id
    LIMIT 1;

    SELECT ArztID, Name
    FROM Arzt
    WHERE AbteilungID = patient_abteilung;

    SELECT RaumID, Name
    FROM Raum
    WHERE AbteilungID = patient_abteilung;
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE AnwesendePatienten()
BEGIN
    SELECT PatientID, Name, Aufnahmedatum
    FROM Patient
    WHERE Entlassungsdatum IS NULL;
END;
//
DELIMITER ;


DELIMITER ;

DELIMITER //
CREATE PROCEDURE Behandlungsdetails()
BEGIN
    SELECT 
        b.BehandlungID AS ID,
        a.Name AS Arzt,
        pers.Name AS Personal,
        pat.Name AS Patient,
        r.Name AS Raum,
        b.Datum,
        b.Anmerkungen
    FROM Behandlung b
    LEFT JOIN Arzt a ON b.ArztID = a.ArztID
    LEFT JOIN Personal pers ON b.PersonalID = pers.PersonalID
    LEFT JOIN Patient pat ON b.PatientID = pat.PatientID
    LEFT JOIN Raum r ON b.RaumID = r.RaumID;
END;
//
DELIMITER ;

! TODO: 
[x] Procedures mind. 3
[x] Views mind. 3
[] Nutzergruppen + Berechtigungen einstellen
more procedures. Join ist das erste, 
groups / aggregations das zweite

# Views 3 von 3

# Behandlung_Übersicht

CREATE VIEW Behandlung_Übersicht AS
SELECT Behandlung.BehandlungID,
       Patient.Name AS Patient,
       Arzt.Name AS Arzt,
       Raum.Name AS Raum,
       Behandlung.Datum
FROM Behandlung
JOIN Patient
    ON Behandlung.PatientID = Patient.PatientID
JOIN Arzt
    ON Behandlung.ArztID = Arzt.ArztID
JOIN Raum
    ON Behandlung.RaumID = Raum.RaumID;

# Behandlung_Anzahl

CREATE VIEW Behandlung_Anzahl AS 
SELECT a.Name AS Arztname, COUNT(*) AS Behandlungen
FROM Behandlung b
JOIN Arzt a ON b.ArztID = a.ArztID
GROUP BY a.ArztID;

# Personal_Übersicht

CREATE VIEW Personal_Übersicht AS
SELECT  Personal.Name,
        Personal.Rolle,
        Abteilung.Name AS Abteilung
FROM Personal
JOIN Abteilung
    ON Personal.AbteilungID = Abteilung.AbteilungID;

# User und Berechtigungen

Der Superadmin hat Zugriff auf alles, Rezeption kann
sich alles anschauen aber hat nur vollen Zugriff auf 
Termine (Behandlungen) und Patienten. Management hat
kompletten Zugriff auf Personal und Arzt und kann sich
andere Tabellen anschauen

# Superadmin

CREATE USER 'superadmin'@'localhost' IDENTIFIED BY 'superadmin';
GRANT ALL PRIVILEGES ON Krankenhaus.* TO 'superadmin'@'localhost';
FLUSH PRIVILEGES;

# Rezeption

CREATE USER 'rezeption'@'localhost' IDENTIFIED BY 'rezeption';

GRANT SELECT
ON Krankenhaus.* 
TO 'rezeption'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE
ON Krankenhaus.Patient
TO 'rezeption'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE
ON Krankenhaus.Behandlung
TO 'rezeption'@'localhost';

FLUSH PRIVILEGES;

# Management

CREATE USER 'management'@'localhost' IDENTIFIED BY 'management;

GRANT SELECT
ON Krankenhaus.*
TO 'management'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE
ON Krankenhaus.Arzt
TO 'management'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE
ON Krankenhaus.Personal
TO 'management'@'localhost';

FLUSH PRIVILEGES;

18. Beschreiben Sie die Möglichkeiten eines Datenbanktunings.
- Man könnte nach einer gewissen Weile Patienten archivieren, wenn 
die letzte Aktivität z.B x Jahre her ist, um die Datenbankkapazität 
kleiner zu halten. Gleiches gilt für alte Behandlungen, Angestellte 
die länger nicht mehr im Betrieb sind etc.
- Man sollte regelmäßíg Performancechecks durchführen um zu 
prüfen welche Anfragen/Methoden zu lange brauchen/zu viele
Resourcen kosten
- Sollte das Krankenhaus weiter expandieren, könnte man jede
Abteilung (Urologie, innere Medizin, etc...) partitionieren, 
da ein  Rezeptionist für innere Medizin z.B wahrscheinlich keinen
Zugriff auf Urologie braucht.

19. Wie könnte die Datenbanksicherheit erhöht werden?
- Würde man die Datenbank später erweitern mit kritischen Informationen,
wäre es gut diese zu verschlüsseln. Passwörter, etc. 
- Die Passwörter die ich angelegt habe für die Nutzer sind nicht sehr
sicher, für Vorführzwecke habe ich username und passwort einfach gleich-
gehalten aber in einem live environment sollte man diese natürlich
ändern
- Man könnte die Zugriffrechte noch reduzieren, dass Rezeptionisten z.B
nur neue Datensets anlegen und anschauen können aber keine existierenden
löschen kann. 

20. Was wäre für diese Datenbank in Bezug auf Datenschutz und Compliance zu beachten?
- Sensitive information verschlüsseln (insbesondere Informationen zu Personen), 
automatische Logs führen die protokollieren wer auf wann was zugreift, ändert,
hinzufügt oder löscht. Dann gibt es je nach Land und Standort Regeln wie z.B dass
man nach x Jahren die Daten eines Kunden vernichten muss

21. Welche Anforderungen an die Datenbank und die Datenbankadministration könnten
im laufenden Betrieb der Krankenhausverwaltung auftreten
- Die Datenbank muss eventuell irgendwann erweitert werden, wenn die Kapazitäten des
Krankenhauses erhöht werden (mehr Angestellte, mehr Patienten, mehr Räume, etc).
Die Größe des Krankenhauses war jetzt nicht gegeben aber es ist sicherlich nicht
ungewöhnlich wenn Krankenhäuser Datenbanken für jede Abteilung haben, die alle
zwar unabhängig voneinander funktionieren aber auch mehr Energie und Zeit dann
brauchen
