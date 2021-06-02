sudo chmod +x version.conf
source ./version.conf

cd manifest

if [ $REGISTRY != "{REGISTRY}" ]; then
	sed -i "s/tmaxcloudck\/tfc-operator/${REGISTRY}\/tfc-operator/g" 04_deployment.yaml
	sed -i "s/tmaxcloudck\/tfc-worker/${REGISTRY}\/tfc-worker/g" 04_deployment.yaml
fi


sed -i 's/{TFC_VERSION}/'${TFC_VERSION}'/g' 04_deployment.yaml

cd ..

kubectl create -f manifest/
