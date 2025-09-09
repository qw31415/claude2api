# Start from the official Golang image  
FROM golang:1.23-alpine AS build  

# Install git for go modules that might need it
RUN apk add --no-cache git ca-certificates

# Set working directory  
WORKDIR /app  

# Copy go.mod and go.sum files first for better caching  
COPY go.mod go.sum ./  

# Download dependencies  
RUN go mod download  

# Copy the source code  
COPY . .  

# Build the application with optimizations
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o main ./main.go  

# Create a minimal production image  
FROM alpine:latest  

# Install ca-certificates for HTTPS requests
RUN apk --no-cache add ca-certificates tzdata

# Create non-root user for security
RUN adduser -D -s /bin/sh appuser

# Create app directory and set permissions  
WORKDIR /app  
COPY --from=build /app/main .  

# Change ownership to non-root user
RUN chown -R appuser:appuser /app
USER appuser

# Expose port (Render will override this with PORT env var)
EXPOSE 8080

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:${PORT:-8080}/ || exit 1

# Command to run the executable  
CMD ["./main"]  