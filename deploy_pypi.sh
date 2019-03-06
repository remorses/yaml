

test -f ./VERSION || (echo "file VERSION containing current version is needed" && exit 1)

git pull

rm -rf *.egg-info
rm -rf dist
rm -rf build

docker run --rm -v "$PWD":/app treeder/bump patch

python3 setup.py sdist bdist_wheel

python3 -m twine upload  dist/*

version=`cat VERSION`

rm -rf *.egg-info
rm -rf dist
rm -rf build

git add -A
git commit -m "pypi version $version"
git tag -a "$version" -m "version $version"
git push
