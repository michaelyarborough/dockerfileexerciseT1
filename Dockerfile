# Use Python 3.6 or later as a base image
FROM python:latest
# Copy contents into image
 COPY requirements.txt
# Install pip dependencies from requirements
RUN pip install --upgrade pip

RUN pip install -r requirements.txt# Use Python 3.6 or later as a base image
FROM python:latest
# Copy contents into image
 COPY requirements.txt .
# Install pip dependencies from requirements
RUN pip install --upgrade pip

RUN pip install -r requirements.txt
# Set YOUR_NAME environment variable

# Expose the correct port

# Create an entrypoint

# Set YOUR_NAME environment variable

# Expose the correct port

# Create an entrypoint
