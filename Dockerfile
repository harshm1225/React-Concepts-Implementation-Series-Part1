# Use official Node.js 14 image as base
FROM node:14

# Set working directory within the container
WORKDIR /usr/share/app

# Copy package.json to the working directory
COPY package.json /usr/share/app

# Update and upgrade the package list inside the container
RUN apt-get update -y && apt-get upgrade -y

# Install npm package manager inside the container
RUN apt-get install npm -y

# Install dependencies defined in package.json
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the application
RUN npm run build

# List files in the directory to ensure proper copying
RUN ls -lt

# Copy the built files to the specified location for serving
COPY build/* /var/www/html/

# Expose port 80 for external access
EXPOSE 80
