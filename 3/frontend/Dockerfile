FROM node:14-alpine

WORKDIR /app

COPY package.json .

RUN npm install axios --save
RUN npm install body-parser

RUN npm install cors

RUN npm install express

RUN npm install

COPY src/ ./src/

EXPOSE 3000

CMD ["npm", "start"]