# Claude2API - Render部署指南

本指南介绍如何将Claude2API项目部署到Render平台。

## 项目简介

Claude2API是一个将Claude的Web服务转换为API服务的Go应用程序，支持图像识别、文件上传、思维输出等功能。

## 已完成的Render优化

### 1. 端口配置优化
- 修改了`config/config.go`以支持Render的`PORT`环境变量
- 自动检测并使用Render提供的端口，fallback到8080

### 2. Dockerfile优化
- 添加了CA证书和时区数据支持
- 实现了多阶段构建以减小镜像体积
- 添加了非root用户以提高安全性
- 包含健康检查配置
- 添加构建优化标志`-ldflags="-w -s"`

### 3. 部署配置
- 创建了`render.yaml`配置文件
- 创建了`.dockerignore`以优化构建时间
- 添加了根路径健康检查端点

## 部署步骤

### 方法1: 使用render.yaml（推荐）

1. **上传代码到GitHub**
   ```bash
   git add .
   git commit -m "Optimize for Render deployment"
   git push origin main
   ```

2. **在Render控制台创建服务**
   - 访问 [Render Dashboard](https://dashboard.render.com)
   - 点击 "New +" → "Web Service"
   - 连接你的GitHub仓库
   - Render会自动检测到`render.yaml`配置

3. **配置环境变量**
   在Render控制台设置以下环境变量：
   ```
   SESSIONS=sk-ant-sid01-你的session1,sk-ant-sid01-你的session2
   APIKEY=你的API密钥
   PROXY=http://127.0.0.1:10000 (如果需要)
   ```

### 方法2: 手动配置

1. **创建Web Service**
   - 选择你的GitHub仓库
   - Runtime: Docker
   - Build Command: `echo "Using Docker build"`
   - Start Command: `./main`

2. **设置环境变量**
   ```
   PORT (Render自动设置)
   SESSIONS=sk-ant-sid01-你的session1,sk-ant-sid01-你的session2
   APIKEY=你的API密钥
   PROXY=http://127.0.0.1:10000 (可选)
   CHAT_DELETE=true
   MAX_CHAT_HISTORY_LENGTH=10000
   ENABLE_MIRROR_API=false
   MIRROR_API_PREFIX=/mirror
   ```

## 环境变量说明

| 变量名 | 必需 | 默认值 | 说明 |
|--------|------|--------|------|
| PORT | 否 | 8080 | Render自动设置 |
| SESSIONS | 是 | - | Claude会话token，多个用逗号分隔 |
| APIKEY | 是 | - | API访问密钥 |
| PROXY | 否 | - | 代理服务器地址 |
| CHAT_DELETE | 否 | true | 是否自动删除聊天 |
| MAX_CHAT_HISTORY_LENGTH | 否 | 10000 | 最大聊天历史长度 |
| ENABLE_MIRROR_API | 否 | false | 是否启用镜像API |
| MIRROR_API_PREFIX | 否 | /mirror | 镜像API前缀 |

## 健康检查

应用程序提供以下健康检查端点：
- `GET /` - 根路径健康检查
- `GET /health` - 专用健康检查端点

## 部署后验证

1. **检查服务状态**
   - 在Render控制台查看部署日志
   - 确认服务状态为"Live"

2. **测试API端点**
   ```bash
   # 健康检查
   curl https://你的应用名.onrender.com/health
   
   # 模型列表
   curl -H "Authorization: Bearer 你的APIKEY" \
        https://你的应用名.onrender.com/v1/models
   
   # 聊天完成
   curl -X POST https://你的应用名.onrender.com/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer 你的APIKEY" \
        -d '{
          "model": "claude-3-sonnet-20240229",
          "messages": [{"role": "user", "content": "Hello"}],
          "max_tokens": 100
        }'
   ```

## 安全考虑

1. **环境变量安全**
   - 不要在代码中硬编码敏感信息
   - 使用Render的环境变量管理功能

2. **API安全**
   - 设置强密钥作为APIKEY
   - 考虑添加速率限制

3. **容器安全**
   - 使用非root用户运行应用
   - 定期更新基础镜像

## 性能优化

1. **构建优化**
   - 使用多阶段构建减小镜像体积
   - 利用Docker层缓存加速构建

2. **运行时优化**
   - 配置适当的健康检查间隔
   - 监控内存和CPU使用情况

## 故障排除

### 常见问题

1. **端口绑定失败**
   - 确认PORT环境变量正确设置
   - 检查应用是否绑定到0.0.0.0而非localhost

2. **健康检查失败**
   - 确认健康检查端点可访问
   - 检查应用启动日志

3. **构建失败**
   - 检查Dockerfile语法
   - 确认go.mod和依赖正确

### 日志调试

在Render控制台查看实时日志：
1. 选择你的服务
2. 点击"Logs"标签
3. 查看构建和运行时日志

## 支持

如果遇到问题，请检查：
1. Render官方文档: https://render.com/docs
2. 项目GitHub Issues
3. Claude2API相关配置说明

---

*本文档基于Claude2API项目为Render部署优化创建*