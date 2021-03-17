# Vorbereitung
1. Download der Datei *id_rsa* aus ilias. Speichert die Datei am besten auf eurem Desktop, ohne Dateiendung mit dem Namen *id_rsa*.
2. Öffnet eine Powershell (Windows Taste, anschliessend suche nach "Powershell").
3. Wechselt in der Powershell auf euren Desktop: `cd Desktop`
4. Öffnet nun eine ssh Verbindung zum gateway Server in der google Cloud: `ssh -i id_rsa student@34.65.71.18`.
5. Führt den Befehl `pwd` aus, die Ausgabe muss */home/student* sein.
6. Erstellt einen neuen Ordner mit euren initialen. Bsp. Thomas Gosteli: `mkdir tg` und wechselt in den neuen Ordner `cd tg`.
7. Erstellt nun in diesem Ordner ein Ansible Inventory, die Gruppe soll *hosts* heissen und tragt euren persönlichen Host ein (*vm-tg* zum Beispiel):
```plaintext
[hosts]
vm-tg
```
8. Prüft ob ansible funktioniert mit: `ansible all -i inventory -m ping`. Die Ausgabe müsste wie folgt sein:
```plaintext
vm-tg | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```
9. Erstelle nun noch eine Datei *index.html* mit dem folgenden Inhalt und deinen Initialen:
```html
<h1>vm-tg</h1>
```

10. Ein `ls -la` sollte nun den folgenden Output liefern:
```plaintext
drwxr-xr-x 2 student student 4096 Mar 17 16:00 .
drwxr-xr-x 7 student student 4096 Mar 17 16:00 ..
-rw-r--r-- 1 student student   17 Mar 17 15:56 index.html
-rw-r--r-- 1 student student   14 Mar 17 15:45 inventory
```

# Aufgabe
Erstelle ein Playbook mit dem Namen *main.yml* das auf deiner persönlichen virtuellen Maschine folgendes installiert/konfiguriert:

Du kannst das Playbook wie folgt ausführen: `ansible-playbook -i inventory main.yml`

1. Installiere das Paket lighttpd. Tipp: `package` oder `apt`
2. Starte den Service lighttpd, aktiviere auch den automatischen Start. Tipp: `service`
3. Kopiere die Datei vom Gateway Server *index.html* auf deine persönliche VM nach */var/www/html/index.html*. Owner: root, Gruppe: root, Berechtigung: 0644. Tipp: `copy`
4. Führe das Playbook aus und prüfe mit `curl vm-tg` (Initialen anpassen!) ob lighttp funktioniert und du deine "Website" siehst. Die Ausgabe müsste wie folgt sein:
```
student@gateway:~/tg$ curl vm-tg
<h1>vm-tg</h1>
```
5. Erstelle eine weitere html Datei mit dem Namen *dynamic.html.j2* und folgendem Inhalt:
```jinja2
<h1>{{ ansible_fqdn }}</h1>
```

Du solltest nun folgende Dateien haben:
```plaintext
student@gateway:~/tg$ ls -l
total 12
-rw-r--r-- 1 student student   0 Mar 17 16:08 dynamic.html.j2
-rw-r--r-- 1 student student  17 Mar 17 15:56 index.html
-rw-r--r-- 1 student student  14 Mar 17 15:45 inventory
-rw-r--r-- 1 student student 312 Mar 17 16:00 main.yml
```
7. Erweitere dein Playbook, so dass die Templatedatei *dynamic.html.j2* auf deine persönliche VM kopiert wird nach */var/www/html/dynamic.html*. Owner: root, Gruppe: root, Berechtigung: 0644. Tipp: `template`
8. Prüfe wieder mit curl ob alles funktioniert wie es soll: `curl vm-tg/dynamic.html`. Die Ausgabe müsste wie folgt sein:
```
student@gateway:~/tg$ curl vm-tg/dynamic.html
<h1>vm-tg.europe-west6-a.c.tsbe-306406.internal</h1>
```
9. Erweitere die Datei *dynamic.html.j2* damit das `curl vm-tg/dynamic.html` folgenden Ouput erzeugt und verwende dazu zwei Variabeln!
```
student@gateway:~/tg$ curl vm-tg/dynamic.html
<h1>vm-tg.europe-west6-a.c.tsbe-306406.internal</h1>
<p>My OS is Debian based and I run on Google Compute Engine</p>
```

Tipp mit `ansible -m setup -i inventory all` erhälst du eine Liste mit allen Variabeln die du verwenden kannst.

> Nicht vergessen, Hilfe gibts mit `ansible-doc` - Beispiel: `ansible-doc template`!