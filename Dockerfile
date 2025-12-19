# syntax=docker/dockerfile:1

# Ajuster la version Node.js si besoin
ARG NODE_VERSION=24.7.0
FROM node:${NODE_VERSION}-slim AS base

LABEL fly_launch_runtime="Node.js"

# Répertoire de l'application
WORKDIR /app

# Définir l'environnement en production
ENV NODE_ENV="production"

# --- Build stage pour réduire la taille finale ---
FROM base AS build

# Installer les dépendances nécessaires à la compilation des modules Node
RUN apt-get update -qq && \
    apt-get install -y build-essential pkg-config python-is-python3 && \
    rm -rf /var/lib/apt/lists/*

# Copier les fichiers de dépendances et installer les modules
COPY package*.json ./
RUN npm ci --only=production

# Copier le reste de l'application
COPY . .

# --- Image finale ---
FROM base

# Copier les modules et l'application construite depuis le stage build
COPY --from=build /app /app

# Exposer le port sur lequel l'application écoute
EXPOSE 3000

# Commande par défaut pour démarrer l'application
CMD ["npm", "run", "prod"]
