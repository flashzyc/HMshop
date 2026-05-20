# 无敌纯血大鸿蒙

<div align="center">

![Java](https://img.shields.io/badge/Java-99.6%25-orange)
![TypeScript](https://img.shields.io/badge/TypeScript-0.4%25-blue)
![License](https://img.shields.io/badge/License-MIT-green)

**一个致力于鸿蒙生态复兴的商城应用项目**

[简介](#简介) • [功能特性](#功能特性) • [技术栈](#技术栈) • [快速开始](#快速开始) • [项目结构](#项目结构) • [贡献指南](#贡献指南)

</div>

---

## 简介

HMshop 是一个为鸿蒙操作系统生态打造的现代化商城应用。本项目旨在展示如何利用 Java 和鸿蒙 API 打造一个功能完整、用户体验优秀的电商平台，同时探索鸿蒙生态的开发潜力。

**项目目标：** 复活鸿蒙生态，打造一个可供学习和参考的完整商城解决方案。

---

## 功能特性

### 核心功能
- 🛍️ **产品展示** - 支持分类浏览、搜索、过滤等多种产品发现方式
- 🛒 **购物车** - 灵活的购物车管理，支持批量操作
- 💳 **订单管理** - 完整的订单生命周期管理
- 👤 **用户系统** - 用户注册、登录、个人中心等功能
- 📱 **响应式设计** - 完美适配不同屏幕尺寸

### 高级功能
- 🔍 **智能搜索** - 快速精准的产品搜索
- ⭐ **收藏系统** - 收藏喜爱的产品
- 💬 **商品评价** - 用户评论和评分系统
- 📊 **用户数据统计** - 个性化推荐和数据分析
- 🔐 **安全认证** - 安全的身份验证和数据加密

---

## 技术栈

### 后端技术
- **语言:** Java 99.6%
- **框架:** 
  - Spring Boot - 快速开发框架
  - Spring Cloud - 微服务支持
  - Spring Data JPA - 数据持久化
- **数据库:** MySQL/PostgreSQL
- **缓存:** Redis
- **消息队列:** RabbitMQ/Kafka（可选）

### 前端技术
- **语言:** TypeScript 0.4%
- **框架:** 鸿蒙 HarmonyOS 原生开发
- **UI框架:** ArkUI

### 工具与中间件
- **构建工具:** Maven/Gradle
- **API文档:** Swagger/OpenAPI
- **容器化:** Docker
- **版本控制:** Git

---

## 快速开始

### 前置要求
- Java 11 或更高版本
- Maven 3.6+ 或 Gradle 7.0+
- MySQL 5.7+ 或 PostgreSQL 12+
- 鸿蒙 DevEco Studio（用于前端开发）

### 环境配置

1. **克隆仓库**
```bash
git clone https://github.com/flashzyc/HMshop.git
cd HMshop
```

2. **配置数据库**
```bash
# 创建数据库
mysql -u root -p < init_database.sql

# 配置 application.properties 文件
cp src/main/resources/application.properties.example src/main/resources/application.properties

# 编辑配置文件，修改数据库连接信息
```

3. **构建项目**
```bash
# 使用 Maven 构建
mvn clean install

# 或使用 Gradle
gradle build
```

4. **运行项目**
```bash
# 使用 Maven 运行
mvn spring-boot:run

# 或运行 jar 包
java -jar target/hmshop-*.jar
```

5. **访问应用**
- 应用地址：`http://localhost:8080`
- API 文档：`http://localhost:8080/swagger-ui.html`

---

## 项目结构

```
HMshop/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/flashzyc/hmshop/
│   │   │       ├── controller/         # 控制器层
│   │   │       ├── service/            # 业务逻辑层
│   │   │       ├── repository/         # 数据访问层
│   │   │       ├── entity/             # 实体模型
│   │   │       ├── dto/                # 数据传输对象
│   │   │       ├── config/             # 配置类
│   │   │       ├── exception/          # 异常处理
│   │   │       └── util/               # 工具类
│   │   └── resources/
│   │       ├── application.properties  # 应用配置
│   │       ├── db/                     # 数据库脚本
│   │       └── static/                 # 静态资源
│   └── test/                           # 测试代码
├── ui/                                 # 鸿蒙前端代码
│   ├── src/
│   ├── package.json
│   └── ...
├── pom.xml                             # Maven 配置
├── Dockerfile                          # Docker 配置
└── README.md                           # 本文件
```

---

## API 文档

### 用户相关接口
| 方法 | 端点 | 描述 |
|------|------|------|
| POST | `/api/user/register` | 用户注册 |
| POST | `/api/user/login` | 用户登录 |
| GET | `/api/user/profile` | 获取用户信息 |
| PUT | `/api/user/profile` | 更新用户信息 |

### 产品相关接口
| 方法 | 端点 | 描述 |
|------|------|------|
| GET | `/api/products` | 获取产品列表 |
| GET | `/api/products/{id}` | 获取产品详情 |
| POST | `/api/products/search` | 搜索产品 |
| GET | `/api/categories` | 获取分类列表 |

### 订单相关接口
| 方法 | 端点 | 描述 |
|------|------|------|
| POST | `/api/orders` | 创建订单 |
| GET | `/api/orders` | 获取订单列表 |
| GET | `/api/orders/{id}` | 获取订单详情 |
| PUT | `/api/orders/{id}` | 更新订单状态 |

详细的 API 文档请查看 [Swagger 文档](http://localhost:8080/swagger-ui.html)

---

## 开发指南

### 本地开发

1. **创建功能分支**
```bash
git checkout -b feature/your-feature-name
```

2. **进行开发和测试**
```bash
# 运行测试
mvn test

# 检查代码质量
mvn checkstyle:check
```

3. **提交代码**
```bash
git commit -m "feat: 描述你的更改"
git push origin feature/your-feature-name
```

### 代码规范

- 遵循 Google Java Style Guide
- 使用有意义的变量名和方法名
- 为复杂逻辑添加注释
- 编写单元测试覆盖核心业务逻辑

---

## 贡献指南

我们欢迎任何形式的贡献，包括但不限于：

### 参与方式
- 🐛 **报告 Bug** - 通过 Issues 提交 bug 报告
- 💡 **提出建议** - 分享你的想法和建议
- 🔧 **提交代码** - 通过 Pull Request 贡献代码
- 📝 **改进文档** - 帮助我们完善文档

### 贡献流程

1. Fork 本仓库
2. 创建你的功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开一个 Pull Request

---

## 常见问题

### Q: 如何修改数据库连接信息？
A: 编辑 `src/main/resources/application.properties` 文件，修改以下配置：
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/hmshop
spring.datasource.username=root
spring.datasource.password=your_password
```

### Q: 如何运行测试？
A: 使用以下命令：
```bash
mvn test
```

### Q: 如何构建 Docker 镜像？
A: 使用以下命令：
```bash
docker build -t hmshop:latest .
docker run -p 8080:8080 hmshop:latest
```

### Q: 项目支持鸿蒙哪些版本？
A: 支持鸿蒙 3.0 及以上版本

---

## 性能优化建议

- 🚀 使用 Redis 缓存热点数据
- 📊 定期分析数据库查询性能
- 🔄 实现异步处理和队列机制
- 💾 优化图片和静态资源的加载

---

## 问题排查

### 常见问题解决方案

| 问题 | 解决方案 |
|------|--------|
| 数据库连接失败 | 检查 MySQL 服务是否运行，验证连接配置 |
| 端口被占用 | 修改 `application.properties` 中的 `server.port` |
| Maven 依赖下载缓慢 | 配置阿里云 Maven 镜像源 |
| 鸿蒙前端编译失败 | 检查 DevEco Studio 版本和 SDK 配置 |

---

## 许可证

本项目采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

---

## 致谢

感谢所有为这个项目做出贡献的开发者和测试人员！

特别感谢：
- 鸿蒙开发者社区
- Spring Boot 社区
- 所有参与者的支持和建议

---

## 联系方式

- 📧 **Email**: flashzyc@example.com
- 🐦 **GitHub Issues**: [提交问题](https://github.com/flashzyc/HMshop/issues)
- 💬 **讨论区**: [项目讨论](https://github.com/flashzyc/HMshop/discussions)

---

## 项目路线图

- [x] 基础项目搭建
- [x] 用户认证系统
- [x] 产品管理模块
- [x] 购物车和订单系统
- [ ] 支付集成
- [ ] 推荐系统
- [ ] 实时通知
- [ ] 性能优化
- [ ] 移动端适配

---

<div align="center">

**⭐ 如果这个项目对你有帮助，请给个 Star！**

Made with ❤️ by [flashzyc](https://github.com/flashzyc)

</div>
