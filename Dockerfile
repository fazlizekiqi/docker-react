# Multi step docker build
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Everything from the builder will drop down i.e the File system snapshot after we start the nginx container
FROM nginx
#Nginx is will look by default at the /usr/share/nginx/html and serve that file
COPY --from=builder /app/build /usr/share/nginx/html


