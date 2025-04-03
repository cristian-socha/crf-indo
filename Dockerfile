FROM python:3.9-alpine

# Install build dependencies and Microsoft ODBC driver
RUN apk add --no-cache \
    gcc \
    musl-dev \
    python3-dev \
    g++ \
    unixodbc \
    unixodbc-dev \
    curl \
    gnupg \
    && curl -O https://download.microsoft.com/download/e/4/e/e4e67866-dffd-428c-aac7-8d28ddafb39b/msodbcsql17_17.10.2.1-1_amd64.apk \
    && apk add --allow-untrusted msodbcsql17_17.10.2.1-1_amd64.apk \
    && rm msodbcsql17_17.10.2.1-1_amd64.apk

WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Set environment variables
ENV PORT=8080
ENV ACCEPT_EULA=Y

# Run the application
CMD ["python", "src/main.py"]