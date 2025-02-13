# Use official Python image
FROM python:3.12

# Set working directory
WORKDIR /app

# Copy application code
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install Nginx properly
RUN apt-get update && apt-get install -y nginx


# Remove default Nginx configuration
RUN rm -f /etc/nginx/sites-enabled/default

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/sites-enabled/

# Expose required ports
EXPOSE 80 8000

# Start Nginx and FastAPI together
CMD ["sh", "-c", "service nginx start && uvicorn main:app --host 0.0.0.0 --port 8000"]
