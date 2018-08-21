import Vapor
import Leaf
//import FluentSQLite
import FluentMySQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
   
    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    // 注册所需要的模块
    try services.register(LeafProvider())
    // 配置prefer的viewRenderer为leafRenderer
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    try services.register(FluentMySQLProvider())
    let mysqlConfig = MySQLDatabaseConfig(hostname: "127.0.0.1", port: 3306, username: "root", password: "910114", database: "mycooldb", transport: .unverifiedTLS)
    services.register(mysqlConfig)
    
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .mysql)
    services.register(migrations)
    
//        try services.register(FluentSQLiteProvider())
//    var databases = DatabasesConfig()
//    try databases.add(database: SQLiteDatabase(storage: .memory), as: .sqlite)
//    services.register(databases)
//    var migrations = MigrationConfig()
//    migrations.add(model: User.self, database: .sqlite)
//    services.register(migrations)
    
//    let myService = NIOServerConfig.default(port: 8080)
//    services.register(myService)
}
