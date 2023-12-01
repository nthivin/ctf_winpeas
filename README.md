# ctf_winpeas
A CTF project focused on using winpeas 



The expected steps of the CTF





Fr :
1 - le testeur accède au site web d'un prestaire hébergeant les sites web de différentes entreprises (BTP, Plomberie ou autre)

2 - L' analyse des pages non référencées du site permet d'accéder à une page admin (fausse piste) mais aussi à une page ressources humaines 

3 - Cette page contient la liste des identifiants par défaut créés pour les nouveaux stagiaires de l'entreprise, ce derniers ont été priés de les changer

4 - L'un des mots de passe n'a pas été changé et il suffit de le déhacher pour avoir accès à l'utilisateur correspondant sur la VM

5 - Cet utilisateur possède peu de privilèges, il s'agit alors de réaliser une élévation de privilèges en utlisant Winpeas puisque la VM est sous Windows. 

6 - L'ajout du fichier Winpeas sur la VM se fait à l'aide d'un serveur Python

7 - Une fois l'élévation de privilèges effectuée, un fichier passwd dans le répertoire root offre les identifiants admin pour les sites hébergés par le prestaire 

8 - le drapeau se trouvera sur un ou plusieurs de ces sites




gobuster dir -u localhost -w wordlist.txt
libreoffice2john employeeList.ods > hash.txt
john --wordlist=rockyou.txt hash.txt
mdp employeeList.ods: ~!@#$%^&*()_+
