node {

  currentBuild.result = "SUCCESS"

  try {
	  stage 'Checkout'
		checkout scm

	  if (env.BRANCH_NAME == 'develop') {
		stage ('Linting')
		  checkout scm
          buildDevelop()
          cleanup()
	  } else if (env.BRANCH_NAME == 'master') {
		  echo "try to build from master branch.."
          stage ('Linting')
            checkout scm
            //sh 'docker run -i --rm -v "$PWD/Dockerfile":/Dockerfile:ro redcoolbeans/dockerlint'
            //buildMaster()
            //deployMaster()
            cleanup()
	  } else if (env.BRANCH_NAME == 'release') {
		  echo "try to build from release branch.."
	  } else {
		  echo "what should i do?"
	  }
  }

  catch (err) {
    echo "Docker Syntax Error!"
    currentBuild.result = "FAILURE"
    throw err
  }
}

def buildDevelop() {
  stage 'Build'
    def dockerfile = 'Dockerfile'
    def customImage = docker.build("alpine-caddy:${env.BUILD_ID}", "-f ${dockerfile} . ")
    customImage.push()
    customImage.push('latest')
}

def buildMaster() {
  stage 'Build'
    def dockerfile = 'Dockerfile'
    def customImage = docker.build("alpine-caddy:${env.BUILD_ID}", "-f ${dockerfile} . ")
    customImage.push()
    customImage.push('latest')
}

def cleanup() {
  stage('Cleanup Images') {
    echo "Cleanup Dangling Images"
    //sh 'if [[ -n "$( docker images -q )" ]] ; then docker rmi -f $(docker images -q) > /dev/null 2>&1 ; fi'
    sh 'docker image prune -f || echo "none.."'
    echo "Cleanup Unused and Stopped Containers"
    sh 'if [[ -n "$( docker ps -a -q )" ]] ; then docker rm $(docker ps -a -q) > /dev/null 2>&1 ; fi || echo "none unused.."'
  }
}
