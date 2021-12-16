FROM node:14
WORKDIR /usr/app/backend
COPY package*.json .
RUN npm install
COPY . .
EXPOSE 8080
CMD npm run dev
