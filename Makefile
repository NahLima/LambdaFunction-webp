.PHONY: all

all: image dependencies-origin dependencies-viewer package-origin package-viewer

image:
	docker build --tag lambci/lambda:build-nodejs14.x .

dependencies-origin: image
	docker run --rm --volume ${PWD}/lambda/respostaOrigem:/build lambci/lambda:build-nodejs14.x /bin/bash -c "source ~/.bashrc; npm init -f -y; npm install sharp --save; npm install querystring --save; npm install --only=prod"

dependencies-viewer: image
	docker run --rm --volume ${PWD}/lambda/requisicaoVisualizador:/build lambci/lambda:build-nodejs14.x /bin/bash -c "source ~/.bashrc; npm init -f -y; npm install querystring --save; npm install path --save; npm install useragent --save; npm install yamlparser; npm install --only=prod"

package-origin: dependencies-origin
	mkdir -p dist && cd lambda/respostaOrigem && zip -FS -q -r ../../dist/respostaOrigem.zip * && cd ../..

package-viewer: dependencies-viewer
	mkdir -p dist && cd lambda/requisicaoVisualizador && zip -FS -q -r ../../dist/requisicaoVisualizador.zip * && cd ../..


	
	
