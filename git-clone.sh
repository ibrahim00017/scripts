#!/usr/bin/env bash
#premier parametre representant le repertoire dans lequel sera cloner tous les projets
#repository_dir=$1

#deuxieme parametre representant la branche de laquelle on doit cloner les les projets
#branch=$2
#user=$3
#password=$4
pag=echo "pwd"
echo "$pag"
git clone https://github.com/ibrahim00017/scripts.git 

mkdir jars && cd jars
jars=echo "pwd"

echo "============CLONAGE DES RESOURCES JARS====================="
./../scripts/git-clone-jar.sh "$jars" release_1.4.0

git clone https://github.com/ibrahim00017/pagdevops.git
cd pagdevops
pagdevops=echo "pwd"
cd ..
echo "=========================CLONAGE DES SERVICES DU PAG=================="
./scripts/git-clone-sf.sh release_2.0
echo "=========================FIN CLONAGE DES SERVICES DU PAG============================="

echo "=========================CLONAGE DE LA RESSOURCE elasticsearch============================"
git clone -b dev https://github.com/ibrahim00017/elasticsearch.service.git

echo "===========COPIE DES DOSSIER CONFIG MEDIA EPUB DANS LE HOME=============="
cp -r scripts/home /home

echo "=======FIN DE LACOPIE DES DOSSIER CONFIG MEDIA EPUB DANS LE HOME========"

echo "=======DEPLOYEMENT DES RESSOURCES JARS========"
cp scripts/jar/pom.xml "$jar"

cd jars && mvn -DskipTests install deploy 
cd ../elasticsearch.service
mvn -DskipTests install deploy

cd "$pagdevops"
mvn -DskipTests  -P dev clean install




#pagdevops= echo "$pag./pagdevops"
#echo "$pagdevops"
#Un tableau contenant le nom de tous les projets 

#projets=("categorie.service.fonctionnel" "projet.service.fonctionnel" "commentaire.service.fonctionnel" "media.service.fonctionnel" "liketable.service.fonctionnel" "note.service.fonctionnel" "debat.service.fonctionnel" "censure.service.fonctionnel" "sondage.service.fonctionnel" "notification.generator.services" "notification.diffusion.services" "preference.service.fonctionnel" "programme.service.fonctionnel" "debat.service.use.case" "bootcamp.user" "statistique.service.fonctionnel")

#On verifie si le repertoire dans lequel sera cloner tous les projets existe
#Et On supprime le repertoire si elle existe
#if [ -d "$repository_dir" ]
#then
#    rm -R "$repository_dir"
#fi https://gitlab.com/exertio/commons.git

#Creation du repertoire dans lequel sera cloner tous les projets existe avec des droits 777 sur le reperstoire
#sudo mkdir -p "$repository_dir"
#sudo chmod -R 777 "$repository_dir"

#Declaration de la methode clone_project qui permet de parcourir le tableau de projet defini en haut
#Pour chaque ittération du tableau on accede au dossier ou l'on doit cloner les projets 
#On affiche ensuite un message ------------------------------ clone  $projet  project----------------------------------------
#Avec $projet l'ittération en cours du tableau
#Enfin on lance la commande git clone 
# clone_project () {
#     for projet in ${projets[@]}
#         do
#             # $1 paramet  er is the name of the project to clone
#             cd "$repository_dir"
#             echo "------------------------------ clone  $projet  project----------------------------------------"
#             git clone https://github.com/rintiobootcamp/"$projet".git -b "$branch"
#     done
# }

#Execution de la fonction clone_project
# clone_project
