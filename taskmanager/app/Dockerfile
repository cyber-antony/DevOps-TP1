# leichtes Python-3.12-Image
FROM python:3.12-slim
# Arbeitsverzeichnis im Container
WORKDIR /app
# Python-Abhängigkeiten kopieren
COPY requirements.txt .
# benötigte Python-Pakete installieren
RUN pip install --no-cache-dir -r requirements.txt
# App in den Container kopieren
COPY app.py .
#Port 6000 für die App deklarieren
EXPOSE 6000
# App starten
CMD ["python", "app.py"]
