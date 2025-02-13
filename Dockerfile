# Use an official Python image
FROM python:3.12

# Set the working directory
WORKDIR /app

# Copy project files
COPY . .

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Install Nginx
RUN apt-get update && apt-get install -y nginx

RUN rm /etc/nginx/sites-enabled/default

COPY nginx.conf etc/nginx/sites-enabled/

# Expose the FastAPI port
EXPOSE 8000

# Run the application
CMD service nginx start && uvicorn main:app --host 0.0.0.0 --port 8000
