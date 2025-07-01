# Use an official Nginx runtime as a parent image
FROM nginx:alpine

# Copy the built frontend files from the frontend image
COPY --from=todo-frontend /app/build /usr/share/nginx/html

# Copy the backend application
COPY --from=todo-backend /app /app

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
