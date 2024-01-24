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
john --format=raw-md5 --wordlist=rockyou.txt hash.txt  

pip install pykeepass  
mdp pass.kdbx: 5Mn]c4KE*Apy)98  

Windows 10 1903 sur archive.org

Set la langue par défaut à français pour avoir un clavier azerty, à faire sur tous les comptes

Désactiver et arrêter Windows Update dans services.msc
Vérif version avec commande systeminfo ou avec winver
Désactiver Windows Defender en le supprimant avec powerrun by sordum (program files + x86 + ProgramData/Microsoft -> à faire 2x avec redémarrage entre) et avec clé registre (dans powerrun) (DisableAntiSpyware) -> faire attention que ça a bien fonctionné après redémarrage (clé toujours présente dans le registre), sinon winpeas est delete auto
Désactiver pare-feu
Installer OpenSSH sur sourceforge.net
Créer un fichier dans les documents de l'admin
Vérifier que curl marche
Créer un utilisateur standard

mdp admin : u+5W53Mzm:2iC[W
mdp Jack.Thompson : 9ph6ni!6M*SS,8C
mdp Scarlett.Harrison : P@ssw0rd123
mdp Mason.Bennett : f.D4vu+{4UaG8D7

qemu-system-x86_64 -hda Windows_10_1903.qcow2 -m 8092 -smp 8
