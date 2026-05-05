# Use a slimmer Node base image to reduce image size
FROM node:18-slim

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Application runs as the default root user (no non-root user created)
EXPOSE 3000

CMD ["node", "server.js"]
