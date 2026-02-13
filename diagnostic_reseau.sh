#!/bin/bash
# Diagnostique complet du reseaux
# Samuel Lortie
# Date : 2026-02-13

#Affichage du nom de l'hôte
nom_de_hote(){
    echo "===== NOM DE L'HOTE ====="
    hostname
}
#Affichage de la date et heure
date_et_heure(){
    echo "===== DATE ET HEURE ====="
    echo "Date: $(date +"%Y-%m-%d")"
    echo "Heure: $(date +"%H:%M")"
}
#Affichage de la version du systèmeXXXXXXXXXXXXXXXXXXXXXXX
ver_system(){
    echo "===== VERSION DU SYSTEME ====="
}
#Affichage de l'adresse IP locale
ip_local(){
    echo "===== ADRESSE IP LOCALE ====="
    hostname -I
}
#Affichage de l'adresse de la passerelle
addr_passerelle(){
    echo "===== ADRESSE DE LA PASSERELLE====="
    ip route | awk '$1=="default" {print $3}'
}
# Affichage des serveurs DNS
serv_dns(){
    echo "===== SERVEUR DNS ====="
    awk '/^nameserver/{print "Serveur configuré: "$2}' /etc/resolv.conf
}
# Test de connectivité localhost
conex_localhost(){
    echo "===== TEST DE CONNECTIVITÉ LOCALHOST ====="
    ping -c 4 localhost
}
# Test de connectivité passerelle
conex_passerelle(){
    echo "===== TEST DE CONNECTIVITÉ PASSERELLE ====="
    ping -c 4 $(ip route | awk '$1=="default" {print $3}')
}
# Test de connectivité Internet (8.8.8.8)
conex_internet(){
    echo "===== TEST DE CONNECTIVITÉ INTERNET ====="
    ping 8.8.8.8
}
# Test de résolution DNS (google.com)
reso_dns(){
    echo "===== TEST DE RÉSOLUTION DNS SUR GOOGLE.COM====="
    nslookup google.com
}
# Affichage de la table ARP
table_arp(){
    echo "===== TABLE ARP ====="
    arp -a | awk '{print "adresse ip : "$2, "adresse mac : ", $4}'
}
# Résolution DNS de 2+ domaines
dns_2_domaine(){
    for domaine in github.com amazon.ca;do

        echo "===== TEST DOMAINE : $domaine ====="
        if nslookup $domaine 
        then
            echo "Connexion Reussi"
        else
            echo "Connexion Échoué"
        fi
    
}



# Gestion des erreurs (messages si échec)



#