// Déclaration du pipeline Jenkins
pipeline {
    agent any // Utilise n'importe quel agent disponible sur Jenkins

    environment {
        // Nom d'utilisateur Docker Hub
        DOCKER_USERNAME = "masslee2403"
        // Version dynamique de l'image basée sur le numéro de build Jenkins
        IMAGE_VERSION = "1.${BUILD_NUMBER}"
        // Nom complet de l’image Docker
        DOCKER_IMAGE = "${DOCKER_USERNAME}/tp5-app:${IMAGE_VERSION}"
        // Nom du conteneur qui sera lancé
        DOCKER_CONTAINER = "tp5-container"
    }

    stages {
        // Étape 1 : Cloner le dépôt GitHub
        stage("Checkout") {
            steps {
                // Clone la branche main de ton dépôt
                git branch: 'main', url: 'https://github.com/masslee999/TP5.git'
            }
        }

        // Étape 2 : Simuler une phase de test (facultative pour ce projet)
        stage("Test") {
            steps {
                echo "Tests fictifs exécutés avec succès"
            }
        }

        // Étape 3 : Construire l’image Docker à partir du Dockerfile
        stage("Build Docker Image") {
            steps {
                script {
                    bat "docker build -t %DOCKER_IMAGE% ."
                }
            }
        }

        // Étape 4 : Envoyer l’image Docker sur Docker Hub
        stage("Push image to Docker Hub") {
            steps {
                script {
                    // Utilisation d’identifiants Jenkins (à configurer via "credentials")
                    withCredentials([usernamePassword(credentialsId: '6cd1a3a7-f3f8-42c2-a87d-9a08685a6cd3', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]){
                        bat """
                        docker login -u %DOCKER_USER% -p %DOCKER_PASSWORD%
                        echo Docker login successful
                        docker push %DOCKER_IMAGE%
                        """
                    }
                }
            }
        }

        // Étape 5 : Déploiement local de l’image dans un conteneur
        stage("Deploy") {
            steps {
                script {
                    bat """
                    # Arrêter le container s'il existe
                    docker container stop %DOCKER_CONTAINER% || echo "Pas de conteneur à arrêter"
                    #Supprimer le container s'il existe
                    docker container rm %DOCKER_CONTAINER% || echo "Pas de conteneur à supprimer"
                    # Lance un nouveau conteneur en mode détaché(en arrière-plan)
                    docker run -d --name %DOCKER_CONTAINER% -p 8080:80 %DOCKER_IMAGE%
                    """
                }
            }
        }
    }
}
