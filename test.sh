#!/bin/sh

#
# Migrates s from one remote git repository server to another.
# Please note the new repository (bare) must already exist on the new git server.
#
# This script is straight forward: it clones the old repository,
# fetches all branches and pushes them afterwards to the new repository (including tags).
#

#GIT_SERVER_FROM=${GIT_SERVER_FROM:-https://github.com/equiperougebootcamp/
GIT_SERVER_FROM=${GIT_SERVER_FROM:-https://github.com/rintiobootcamp}
#GIT_SERVER_TO=${GIT_SERVER_TO:-http://5.135.129.180:8080/aggroppm/}
GIT_SERVER_TO=${GIT_SERVER_TO:-http://Ibrahim_brain:ahmadiyya0017@5.135.129.180:8080/pag}
REPO_PREFIX=${REPO_PREFIX:-/}
REPOS=${REPOS:-bootcamp.common bootcamp.database service.crud bootcamp.commonws bootcamp.rest.service.client categorie.service.fonctionnel projet.service.fonctionnel commentaire.service.fonctionnel media.service.fonctionnel liketable.service.fonctionnel note.service.fonctionnel debat.service.fonctionnel censure.service.fonctionnel sondage.service.fonctionnel notification.generator.services notification.diffusion.services preference.service.fonctionnel programme.service.fonctionnel projet.service.use.case categorie.service.use.case debat.service.use.case bootcamp.user statistique.service.fonctionnel bootcamp.security}
#TMP_DIR=`mktemp -d -t git_migration.XXXXX` || exit 1
TMP_DIR=`mktemp -d git_migration.XXXXX` || exit 1

pushd $TMP_DIR

echo "====  Migrating from  $GIT_SERVER_FROM$REPO_PREFIX  to  $GIT_SERVER_TO$REPO_PREFIX  ===="

for r in $REPOS ; do

 repo_name=`basename $REPO_PREFIX$r`

echo "==== ${repo_name} ===="

#git clone --no-checkout $GIT_SERVER_FROM$REPO_PREFIX$r.git
git clone --mirror $GIT_SERVER_FROM$REPO_PREFIX$r.git

cd ${repo_name}.git

git remote set-url origin $GIT_SERVER_TO$REPO_PREFIX$r.git
git push --mirror -u origin

cd .. && rm -rf ${repo_name}.git

done

cd .. && rmdir $TMP_DIR
popd
