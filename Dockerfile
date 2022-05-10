# Stage 1: Compile and Build angular codebase
FROM node:14 as builder
WORKDIR /app

ADD package.json .
ADD package-lock.json .

RUN npm install

COPY . .
RUN npm run build --prod



# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM nginx:latest

# Copy the build output to replace the default nginx contents.
COPY --from=builder /app/dist/ /usr/share/nginx/html

# Expose port 80
EXPOSE 80 443

CMD [ "nginx", "-g", "daemon off;" ]


