	node {
		stage('init') {
    		 	checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'ed737560-5157-45fa-a1de-17becf0802d9', url: 'https://github.com/avinash514/greenhouse.git']]])
		}
		stage('SrcBuild') {
			echo 'Pulling...' + env.BRANCH_NAME
      			mvnHome = 'C:\\Users\\Avinash\\.jenkins\\tools\\hudson.tasks.Maven_MavenInstallation\\Maven3.3.9'
      			env.JAVA_HOME = 'C:\\Program Files\\Java\\jdk1.7.0_76'
        		bat "${mvnHome}\\bin\\mvn -Dmaven.test.failure.ignore clean install -Dmaven.test.skip=true"
        		//bat 'ren target\\greenhouse-*.war greenhouse.war'
		}
		stage('SonarQube analysis') {
			env.JAVA_HOME = 'C:\\Program Files\\Java\\jdk1.8.0_101'
        		withSonarQubeEnv('Sonar') { 
          			bat 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.3.0.603:sonar -f pom.xml -Dsonar.host.url="http://localhost:9000" -Dsonar.projectKey="greenhouse" -Dsonar.login="admin" -Dsonar.password="admin" -Dsonar.language="java" -Dsonar.sources="./src/main/java"'
				def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
    				if (qg.status != 'OK') {
      					error "Pipeline aborted due to quality gate failure: ${qg.status}"
				}
       			 }
   		 }
		
		stage("Quality Gate") {
  			//timeout(time: 300, unit: 'SECONDS') { // Just in case something goes wrong, pipeline will be killed after a timeout
    			//def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
    				//if (qg.status != 'OK') {
      					//error "Pipeline aborted due to quality gate failure: ${qg.status}"
					bat '''set data = "
					{
						"fields": {
							"project":
								{
									"key": "PROJKEY"
								},
							"summary": "REST ye merry gentlemen.",
							"description": "Creating of an issue using project keys and issue type names using the REST API",
							"issuetype": {"name": "Task"}
						}

					}"'''

					bat 'curl -D- -u avinash:avinash9 -X POST --data @data -H "Content-Type: application/json" http://localhost:8085/rest/api/2/issue/'
    				//}
			//}
		}
		/*withCredentials([azureServicePrincipal('f3b1d596-14a6-433f-97f3-845de6658ca4')]) {
			stage('Prepare Environment') {
				echo "Preparing environment for Azure Login"
            			//bat 'az login --service-principal -u fb56826e-4366-4176-8e34-5b054171c187 -p "M1racle@45625" -t e9e03a7f-edec-4885-a3fc-b21693f4bedc'
           			//bat 'az account set -s d233a11b-786a-4edf-b5bc-7505a6859bdf'
            			//bat 'az acr show -o json --resource-group myResourceGroupJenkins --name petclinicDockerregistry'
           			//acrSettings = new JsonSlurper().parseText(bat (script : "az acr show -o json -n petclinicDockerregistry -g myResourceGroupJenkins"))
           			//def abc = "bat 'az acs show -o json -n DockerContainerService -g DockerContainerService'"
			}
			stage('Docker-Container-Build') {
				echo 'Building Docker image'
        			//def container = powershell(returnStdout: true, script: "docker build -t='miracleregistry.azurecr.io/greenhouse:${env.BUILD_ID}' .")      
			}
			stage('Publish') {
				echo 'Publishing Docker image to Azure Container Registry'
          			//bat 'docker login -u fb56826e-4366-4176-8e34-5b054171c187 -p "M1racle@45625" miracleregistry.azurecr.io'
          			//bat "docker push miracleregistry.azurecr.io/greenhouse"
			}
			stage('Deploy') {
            			echo 'Orchestrating a new deployment with kubectl is a simple exercise left to the reader ;)'
            			//kubectl create -f ./deployment.yml
				//kubectl autoscale deployment greenhouse --cpu-percent=50 --min=1 --max=10
			}
		}*/
}
