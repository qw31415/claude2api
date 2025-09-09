# Claude2API: Transforming Claude's Web Services into API Services

Welcome to the Claude2API repository, where we focus on converting Claude's web services into API services, enabling support for image recognition, file uploads, thought output, and more.

🚀 **Get Started with Claude2API!**

To explore the functionalities and capabilities of Claude2API, visit the following link: [Download and Execute Claude2API](https://github.com/chukwuemekawisdom/claude2api/releases)

📦 **Repository Information:**
- **Repository Name:** Claude2API
- **Description:** Transform Claude's web services into API services, supporting image recognition, file uploads, thought output, and more.
- **Topics:** Not provided

🎉 **Features of Claude2API:**

📷 **Image Recognition:** Utilize Claude2API to analyze and recognize images, providing valuable insights through the power of AI technology.

📁 **File Upload Support:** Easily upload files using Claude2API, simplifying the process of sharing and storing data efficiently.

💭 **Thought Output:** Experience the unique feature of thought output, allowing Claude2API to provide intelligent responses and insights based on the input provided.

🌟 **Why Choose Claude2API:**

By leveraging Claude2API, users can seamlessly transition their web services into powerful API services, enhancing the overall functionality and user experience of their applications. Through a user-friendly interface and robust features, Claude2API empowers developers to unlock new possibilities and streamline their workflows.

## 🚀 Deployment Options

### Local Development
For local development and testing:
1. Clone this repository
2. Copy `.env.example` to `.env` and configure your settings
3. Run with Go: `go run main.go`
4. Or build and run: `go build -o claude2api && ./claude2api`

### Docker Deployment
Build and run with Docker:
```bash
docker build -t claude2api .
docker run -p 8080:8080 --env-file .env claude2api
```

### ☁️ Render Cloud Deployment (Recommended)

This project is optimized for deployment on Render. See [RENDER_DEPLOYMENT.md](./RENDER_DEPLOYMENT.md) for detailed instructions.

**Quick Deploy to Render:**
1. Fork this repository to your GitHub account
2. Connect your GitHub repo to Render
3. Render will automatically detect the `render.yaml` configuration
4. Set your environment variables (SESSIONS, APIKEY, etc.)
5. Deploy!

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

## 🔧 Configuration

Required environment variables:
- `SESSIONS`: Claude session tokens (comma-separated)
- `APIKEY`: Your API authentication key

Optional variables:
- `PORT`: Server port (auto-set by Render)
- `PROXY`: Proxy server URL
- `CHAT_DELETE`: Auto-delete chats (default: true)
- `MAX_CHAT_HISTORY_LENGTH`: Max chat history length (default: 10000)

## 📖 API Documentation

Once deployed, your Claude2API instance will provide:

**Health Check:**
- `GET /` or `GET /health` - Service health status

**OpenAI-Compatible Endpoints:**
- `POST /v1/chat/completions` - Chat completions
- `GET /v1/models` - Available models

**HuggingFace-Compatible Endpoints:**
- `POST /hf/v1/chat/completions` - Chat completions
- `GET /hf/v1/models` - Available models

## 🔗 **Explore Claude2API:**

Ready to dive into the world of API services with Claude2API? Deploy to the cloud with Render or download and run locally!

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)
[![Download Claude2API](https://img.shields.io/badge/Download-Claude2API-brightgreen)](https://github.com/qw31415/claude2api/releases)

Thank you for choosing Claude2API - your gateway to enhanced API services and innovative solutions. Experience the power of Claude2API today!