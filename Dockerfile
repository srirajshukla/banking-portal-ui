# Stage 1: Build the Angular application
FROM node:20-alpine as builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Ensure a clean install of dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of the application code
COPY . .

# Set higher memory limit for Node.js to prevent "JavaScript heap out of memory"
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Build the application with correct command
RUN npm run build --prod

# Stage 2: Serve the application using Nginx
FROM nginx:alpine

# Copy the build output from builder stage
COPY --from=builder /app/dist/* /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]


















# # Stage 1: Build the Angular application
# FROM node:20-alpine as builder

# # Set working directory
# WORKDIR /app

# # Copy package.json and package-lock.json
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application code
# COPY . .

# # Build the application
# RUN npm run build --prod

# # Stage 2: Serve the application using Nginx
# FROM nginx:alpine

# # Copy the build output from builder stage
# COPY --from=builder /app/dist/* /usr/share/nginx/html/

# # Copy custom Nginx configuration if needed
# # COPY nginx.conf /etc/nginx/conf.d/default.conf

# # Expose port 80
# EXPOSE 80

# # Start Nginx server
# CMD ["nginx", "-g", "daemon off;"]
