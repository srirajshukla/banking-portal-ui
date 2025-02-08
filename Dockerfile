# Stage 1: Build the Angular application
FROM node:20-alpine as builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build --prod

# Stage 2: Serve the application using Nginx
FROM nginx:alpine

# Copy the build output from builder stage
COPY --from=builder /app/dist/* /usr/share/nginx/html/

# Copy custom Nginx configuration if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]