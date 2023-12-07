# Use Python 3.6 or later as a base image

FROM python:latest

# Copy requirements file over

COPY requirements.txt .

# Install pip dependencies from requirements

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

# Copy contents into image

COPY . .

# Set YOUR_NAME environment variable

ENV YOUR_NAME QA

# Expose the correct port

EXPOSE 5500

# Create an entrypoint

ENTRYPOINT ["python","app.py"]

Use “touch” to create a file called Dockerfile.nginx and add the following:

FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf
