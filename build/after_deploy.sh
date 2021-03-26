NEW_URL="https://single-spa-react-demo.s3.amazonaws.com/dashboard/${GITHUB_SHA}/cd-dashboard.js"

echo "Downloading import map from S3"
aws s3 cp s3://single-spa-react-demo/importmap.json importmap.json

echo "Updating import map to point to new version of"
echo $(jq --arg variable "$NEW_URL" '.imports["@cd/dashboard"] = $variable' importmap.json) > importmap.json

echo "New Url = ${NEW_URL}"
cat importmap.json

echo "Uploading new import map to S3"
aws s3 cp importmap.json s3://single-spa-react-demo/importmap.json --cache-control 'public, must-revalidate, max-age=0' --acl 'public-read'
echo "Deployment successful"