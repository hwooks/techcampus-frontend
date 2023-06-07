# Build stage
FROM node:16 AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Run stage
FROM node:16
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/build ./build
RUN npm install -g serve
EXPOSE 5000
CMD ["serve", "-s", "build"]
