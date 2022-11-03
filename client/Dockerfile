FROM node:14.14.0-alpine as build

WORKDIR /app

COPY ./package.json ./
RUN npm i

COPY . .

RUN npm run build

FROM nginx
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf