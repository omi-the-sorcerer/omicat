FROM node:latest as build-stage
WORKDIR /app

COPY public public/
COPY src src/
COPY package.json package.json
COPY vite.config.js vite.config.js
COPY index.html index.html

RUN npm install
RUN npm run build

FROM nginx:latest as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]