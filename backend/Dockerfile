FROM node:14
WORKDIR /usr/app/backend
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run prisma:generate
RUN npm run build
RUN cp -R src/views dist/
RUN cp -R src/public dist/
EXPOSE 8080
CMD ./run-backend.sh