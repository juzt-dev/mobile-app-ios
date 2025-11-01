# Backend Setup Guide - Swift Vapor

## Create Backend Project

### 1. Cài đặt Vapor Toolbox

```bash
brew install vapor
```

### 2. Create new Vapor project

```bash
vapor new MobileAppBackend
cd MobileAppBackend
```

### 3. Backend Structure

```
MobileAppBackend/
├── Sources/
│   └── App/
│       ├── configure.swift
│       ├── routes.swift
│       ├── Controllers/
│       │   ├── AuthController.swift
│       │   └── UserController.swift
│       ├── Models/
│       │   └── User.swift
│       ├── Migrations/
│       │   └── CreateUser.swift
│       ├── Middleware/
│       │   └── AuthMiddleware.swift
│       └── DTOs/
│           └── AuthDTOs.swift
├── Tests/
└── Package.swift
```

## 🔧 Implementation

### Models/User.swift

```swift
import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Field(key: "name")
    var name: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() {}
    
    init(id: UUID? = nil, email: String, passwordHash: String, name: String) {
        self.id = id
        self.email = email
        self.passwordHash = passwordHash
        self.name = name
    }
}

extension User {
    func toDTO() -> UserDTO {
        UserDTO(
            id: self.id!,
            email: self.email,
            name: self.name,
            createdAt: self.createdAt!,
            updatedAt: self.updatedAt!
        )
    }
}
```

### DTOs/AuthDTOs.swift

```swift
import Vapor

struct LoginRequest: Content {
    let email: String
    let password: String
}

struct LoginResponse: Content {
    let token: String
    let refreshToken: String
    let user: UserDTO
}

struct RegisterRequest: Content {
    let email: String
    let password: String
    let name: String
}

struct RegisterResponse: Content {
    let token: String
    let refreshToken: String
    let user: UserDTO
}

struct UserDTO: Content {
    let id: UUID
    let email: String
    let name: String
    let createdAt: Date
    let updatedAt: Date
}
```

### Controllers/AuthController.swift

```swift
import Vapor
import Fluent

struct AuthController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let auth = routes.grouped("auth")
        auth.post("login", use: login)
        auth.post("register", use: register)
        auth.post("logout", use: logout)
    }
    
    func login(req: Request) async throws -> LoginResponse {
        let loginRequest = try req.content.decode(LoginRequest.self)
        
        guard let user = try await User.query(on: req.db)
            .filter(\.$email == loginRequest.email)
            .first() else {
            throw Abort(.unauthorized, reason: "Invalid credentials")
        }
        
        let isValidPassword = try await req.password.async.verify(
            loginRequest.password,
            created: user.passwordHash
        )
        
        guard isValidPassword else {
            throw Abort(.unauthorized, reason: "Invalid credentials")
        }
        
        let token = try generateToken(for: user)
        let refreshToken = try generateRefreshToken(for: user)
        
        return LoginResponse(
            token: token,
            refreshToken: refreshToken,
            user: user.toDTO()
        )
    }
    
    func register(req: Request) async throws -> RegisterResponse {
        let registerRequest = try req.content.decode(RegisterRequest.self)
        
        // Check if user exists
        let existingUser = try await User.query(on: req.db)
            .filter(\.$email == registerRequest.email)
            .first()
        
        guard existingUser == nil else {
            throw Abort(.conflict, reason: "Email already registered")
        }
        
        // Hash password
        let passwordHash = try await req.password.async.hash(registerRequest.password)
        
        // Create user
        let user = User(
            email: registerRequest.email,
            passwordHash: passwordHash,
            name: registerRequest.name
        )
        
        try await user.save(on: req.db)
        
        let token = try generateToken(for: user)
        let refreshToken = try generateRefreshToken(for: user)
        
        return RegisterResponse(
            token: token,
            refreshToken: refreshToken,
            user: user.toDTO()
        )
    }
    
    func logout(req: Request) async throws -> HTTPStatus {
        // Invalidate token (implement token blacklist if needed)
        return .ok
    }
    
    private func generateToken(for user: User) throws -> String {
        // Generate JWT token (implement with JWTKit)
        return "mock_token_\(user.id!.uuidString)"
    }
    
    private func generateRefreshToken(for user: User) throws -> String {
        return "mock_refresh_token_\(user.id!.uuidString)"
    }
}
```

### Migrations/CreateUser.swift

```swift
import Fluent

struct CreateUser: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("email", .string, .required)
            .field("password_hash", .string, .required)
            .field("name", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .unique(on: "email")
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}
```

### configure.swift

```swift
import Vapor
import Fluent
import FluentPostgresDriver

public func configure(_ app: Application) async throws {
    // Database configuration
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init) ?? 5432,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor",
        password: Environment.get("DATABASE_PASSWORD") ?? "password",
        database: Environment.get("DATABASE_NAME") ?? "mobile_app"
    ), as: .psql)
    
    // Migrations
    app.migrations.add(CreateUser())
    
    // Middleware
    app.middleware.use(ErrorMiddleware.default(environment: app.environment))
    
    // Routes
    try routes(app)
}
```

### routes.swift

```swift
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "Mobile App API is running!"
    }
    
    try app.register(collection: AuthController())
}
```

## Run Backend

### 1. Cài đặt PostgreSQL

```bash
brew install postgresql
brew services start postgresql
createdb mobile_app
```

### 2. Build và Run

```bash
swift build
swift run App migrate
swift run App serve
```

Server sẽ chạy tại: `http://localhost:8080`

### 3. Test API

```bash
# Register
curl -X POST http://localhost:8080/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123",
    "name": "Test User"
  }'

# Login
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123"
  }'
```

## Security Enhancements

### 1. Setting JWT

```swift
// Package.swift
.package(url: "https://github.com/vapor/jwt.git", from: "4.0.0")

// Token generation
import JWT

struct UserPayload: JWTPayload {
    let userId: UUID
    let exp: ExpirationClaim
    
    func verify(using signer: JWTSigner) throws {
        try self.exp.verifyNotExpired()
    }
}
```

### 2. Rate Limiting

```swift
// Middleware for rate limiting
final class RateLimitMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        // Implement rate limiting logic
        return try await next.respond(to: request)
    }
}
```

## Deploy

### Docker

```dockerfile
FROM swift:5.9
WORKDIR /app
COPY . .
RUN swift build -c release
EXPOSE 8080
CMD [".build/release/App", "serve", "--env", "production", "--hostname", "0.0.0.0"]
```

### docker-compose.yml

```yaml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "8080:8080"
    environment:
      DATABASE_HOST: db
      DATABASE_NAME: mobile_app
      DATABASE_USERNAME: vapor
      DATABASE_PASSWORD: password
    depends_on:
      - db
  
  db:
    image: postgres:15
    environment:
      POSTGRES_USER: vapor
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mobile_app
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

## Environment Variables

Create file `.env`:

```
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_USERNAME=vapor
DATABASE_PASSWORD=password
DATABASE_NAME=mobile_app
JWT_SECRET=your-secret-key-here
```

## Checklist

- [ ] Install Vapor Toolbox
- [ ] Create Vapor project
- [ ] Setup PostgreSQL
- [ ] Implement User model
- [ ] Implement Auth endpoints
- [ ] Add JWT authentication
- [ ] Add validation
- [ ] Add error handling
- [ ] Add tests
- [ ] Deploy to server

---

**Note**: Backend này đã sẵn sàng để kết nối với Mobile App. Đảm bảo cập nhật baseURL trong iOS app để trỏ đến server của bạn.
