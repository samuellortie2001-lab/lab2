#!/bin/bash
# Diagnostique complet du reseaux
# Samuel Lortie
# Date : 2026-02-13


echo "=======DIAGNOSTIC COMPLET DU RESEAU======="
echo
echo
#Affichage du nom de l'hôte
nom_de_hote(){
    echo "===== NOM DE L'HOTE ====="
    echo
    hostname
    echo
}
#Affichage de la date et heure
date_et_heure(){
    echo "===== DATE ET HEURE ====="
    echo
    echo "Date: $(date +"%Y-%m-%d")"
    echo "Heure: $(date +"%H:%M")"
    echo
}
#Affichage de la version du système
ver_system(){
    echo "===== VERSION DU SYSTEME ====="
    echo
    echo "Version : $(uname -r)"
    echo
}
#Affichage de l'adresse IP locale
ip_local(){
    echo "===== ADRESSE IP LOCALE ====="
    echo
    hostname -I
    echo
}
#Affichage de l'adresse de la passerelle
addr_passerelle(){
    echo "===== ADRESSE DE LA PASSERELLE====="
    echo
    ip route | awk '$1=="default" {print $3}'
    echo
}
# Affichage des serveurs DNS
serv_dns(){
    echo "===== SERVEUR DNS ====="
    echo
    awk '/^nameserver/{print "Serveur configuré: "$2}' /etc/resolv.conf
    echo
}
# Test de connectivité localhost
conex_localhost(){
    echo "===== TEST DE CONNECTIVITÉ LOCALHOST ====="
    if ping -c 4 localhost > /dev/null;
    then
            echo
            echo "Connexion Reussi"
        else
            echo
            echo "Connexion Échoué"
        fi

    echo
}
# Test de connectivité passerelle
conex_passerelle(){
    echo "===== TEST DE CONNECTIVITÉ PASSERELLE ====="
    if ping -c 4 $(ip route | awk '$1=="default" {print $3}') > /dev/null;
    then
            echo
            echo "Connexion Reussi"
        else
            echo
            echo "Connexion Échoué"
        fi
    echo
}
# Test de connectivité Internet (8.8.8.8)
conex_internet(){
    echo "===== TEST DE CONNECTIVITÉ INTERNET ====="
    if ping -c 4 8.8.8.8 > /dev/null;
    then
            echo
            echo "Connexion Reussi"
        else
            echo
            echo "Connexion Échoué"
        fi
    echo
}
# Test de résolution DNS (google.com)
reso_dns(){
    echo "===== TEST DE RÉSOLUTION DNS SUR GOOGLE.COM====="
    if nslookup google.com > /dev/null;
    then
            echo
            echo "Connexion Reussi"
        else
            echo
            echo "Connexion Échoué"
        fi
    echo
}
# Affichage de la table ARP
table_arp(){
    echo "===== TABLE ARP ====="
    echo
    ip neigh | awk '{print "adresse ip : "$1, "adresse mac : ", $5}'
    echo
}
# Résolution DNS de 2+ domaines 
dns_2_domaine(){
    for domaine in github.com amazon.ca;do

        echo "===== TEST DOMAINE : $domaine ====="
        if nslookup "$domaine" > /dev/null 
        then
            echo
            echo "Connexion Reussi"
        else
            echo
            echo "Connexion Échoué"
        fi
    echo
    done
            
}


#execution
nom_de_hote
date_et_heure
ver_system
ip_local
addr_passerelle
serv_dns
conex_localhost
conex_passerelle
conex_internet
reso_dns
table_arp
dns_2_domaine