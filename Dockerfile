# Stage 1: Compile and Build angular codebase
FROM node:14
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
COPY --from=build /usr/local/app/dist/sample-angular-app /usr/share/nginx/html

# Expose port 80
EXPOSE 80


