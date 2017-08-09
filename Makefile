compile:
	./build.sh
	mvn install -B -f deploy.pom.xml -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true

clean:
	mvn clean -B -f deploy.pom.xml 

deploy:
	mvn deploy -B -f deploy.pom.xml -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true

.PHONY: clean compile deploy
