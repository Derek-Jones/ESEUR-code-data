Files: pixy.csv, splint.csv, rats.csv
Each file contains, for each vulnerability:
  ID: the unique ID
  FILE: the file where it was detected
  LINE: the source line where it was detected
  CATEG: the vulnerability category according to our classification
  START: snapshot where the vulnerability appeared
  END: snapshot where the vulnerability disappeared or was removed (NA if live at the last snapshot analyzed)
  WASREM: 1 if the vulnerability was removed, 0 otherwise
  WASREMBUG: 1 if the vulnerability was removed because of a bug fixing, 0 otherwise
  DISAP: 1 if the vulnerability disappeared, 0 otherwise
  DISAPBUG: 1 if the vulnerability disappeared because of a bug fixing, 0 otherwise
  HOWDISAP: NA if the vulnerability did not disappear, CHG if it disappeared because of a change in the source code line, COCHG if it disappeared because of a co-change
  LONGDESCR: long vulnerability description as printed by the detection tool
  SYSTEM: analyzed system

Files: Horde-hist.csv, Samba-hist.csv, Squid-hist.csv
Each file contains, for each snapshot:
  TOOL: vulnerability detection tool (pixy, splint, rats)
  SNAPSHOT: snapshot number
  TIMESTAMP: snapshot timestamp
  NRofVULN: the total number of detected vulnerabilities
  
Files: Horde-notes.txt, Samba-notes.txt, Squid-notes.txt
Each file contains, for each snapshot in which a vulnerability has been removed:
  SNAPSHOT: snapshot number
  DOCUMENTED: YES if commit notes reveal a vulnerability removal, NO otherwise
  COMMIT NOTES: the commit notes extracted from cvs
  