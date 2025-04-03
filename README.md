# CRF-INDO

## Project Overview
CRF-INDO is a Python application 

## Installation
To install the required dependencies, run the following command:

```
pip install -r requirements.txt
```

## Usage
To run the application, execute the following command:

```
python src/main.py
```

## Testing
To run the unit tests, use the following command:

```
pytest tests/
```

## Contributing
If you would like to contribute to this project, please fork the repository and submit a pull request.

## Crear DockerFile
## Crear requirements.txt
## Crear estructura del proyecto

# Autenticarse en GCP
gcloud auth configure-docker
gcloud auth configure-docker us-central1-docker.pkg.dev 

# Definir la región y el nombre del repositorio
set REGION=us-central1 ^
set REPO_NAME=crf-indo-alarmset ^
set IMAGE_NAME=crf-indo-function-alarmset 

# Crear el repositorio en Artifact Registry si no existe
gcloud artifacts repositories create %REPO_NAME% --repository-format=docker --location=%REGION% --quiet

# Construir la imagen
docker build -t %REGION%-docker.pkg.dev/%PROJECT_ID%/%REPO_NAME%/%IMAGE_NAME% .

# Subir la imagen a Artifact Registry
docker push %REGION%-docker.pkg.dev/%PROJECT_ID%/%REPO_NAME%/%IMAGE_NAME%

# Desplegar la imagen en Cloud Run
gcloud run deploy crf-indo-alarmset ^
    --image=%REGION%-docker.pkg.dev/%PROJECT_ID%/%REPO_NAME%/%IMAGE_NAME% ^
    --platform=managed ^
    --region=%REGION% ^
    --allow-unauthenticated ^
    --set-env-vars "GCP_PROJECT_ID=observatorio-ino-1,GCP_REGION=us-central1,DB_SERVER=XXXXXXXX,DB_NAME=XXXXXXX,DB_USER=XXXXXX,DB_PASSWORD=XXXXXXXXX

# Describir el servicio de Cloud Run
gcloud run services describe crf-indo-alarmset --platform managed --region us-central1

# Probar el servicio de Cloud Run
curl -X POST "https://crf-indo-alarmset-205735734674.us-central1.run.app" ^
     -H "Content-Type: application/json" ^
     -d '{"key": "value"}'
