set -ex

USERNAME=audiocomp
IMAGE=pycron

git pull origin master

version=`cat VERSION`
echo "version: $version"

git add -A
git commit
git tag -a "$version" -m "version $version"
git push origin master
git push origin master --tags
