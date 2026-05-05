FROM node:20-alpine
WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev
RUN apk update && apk upgrade
COPY . .

EXPOSE 3000

CMD ["node", "server.js"]
