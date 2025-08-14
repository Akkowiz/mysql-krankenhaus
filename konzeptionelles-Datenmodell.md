# Entitäten
- Patient
- Arzt
- Personal
- Raum
- Abteilung
- Termin/Behandlung

Jede Entität besitzt eine ID, PatientID, ArztID, etc ...Wichtig für 
Beziehungen später

# Patient:
PatientID
Name
Adresse
PLZ
Aufnahmedatum
Entlassungsdatum
AbteilungID (Fremdschlüssel)

# Arzt:
ArztID
Name
Adresse
PLZ
AbteilungID (Fremdschlüssel)

# Personal
PersonalID
Name
Rolle
Adresse
PLZ
AbteilungID (Fremdschlüssel)

# Raum
RaumID
Name
AbteilungID (Fremdschlüssel)

# Abteilung
AbteilungID
Name

# Behandlung
BehandlungID
ArztID
PersonalID
PatientID
RaumID
Anmerkungen
