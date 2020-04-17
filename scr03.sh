#!/bin/bash
########################################################################
if (( EUID != 0 ))
then
  echo "Este script se tiene que ejecutar como root o con sus privilegios."
  exit 2 
fi

test=$(aptitude search pwgen | cut -d "p" -f 1)
if [[ $test == "p" ]]
then 
	aptitude -y install pwgen > /dev/null	
fi
#
dades=$(zen --forms --title="Creació de contrasenyes per usuaris" --width=500 --text="Dóna les dades bàsiques dels d'usuaris .fje" \
        --add-entry="Nom base dels usuaris: "  --add-entry="Quantitat d'usuaris: " --add-entry="Mida de la contrasenya: ")
nom_base=$(echo $dades | cut -d '|' -f 1)
qusr=$(echo $dades | cut -d '|' -f 2)
mida=$(echo $dades | cut -d '|' -f 3)
for (( num=1, num<=$qusr; num++ )) 

do
	ctsnya=$(pwgen $mida 1)
	nom_usr=$nom_base$num.fje
	echo "$nom_usr  $ctsnya" >> $nom_base.txt
fi 
exit 0

