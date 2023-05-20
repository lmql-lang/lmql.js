set +x

echo "📦  Packaging LMQL for In-Browser use..."
echo $(pwd)
pushd lmql/web/browser-build
bash browser-build.sh
popd
cp -r lmql/web/browser-build/dist/wheels js/
cp -r lmql/web/browser-build/dist/lmql.web.min.js js/

# check for --push
if [ "$1" = "--push" ]; then
    echo "🚀  Deploying website to GitHub $REPO..."
    pushd ../web-deploy
    echo "lmql.ai" > CNAME
    npx gh-pages -d . -r git@github.com:$REPO.git -f
    popd
fi
