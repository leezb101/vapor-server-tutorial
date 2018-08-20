import Vapor
import Leaf
import FluentSQLite

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
   
    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    // 注册所需要的模块
    try services.register(LeafProvider())
    try services.register(FluentSQLiteProvider())
    // 配置prefer的viewRenderer为leafRenderer
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    var databases = DatabasesConfig()
    try databases.add(database: SQLiteDatabase(storage: .memory), as: .sqlite)
    services.register(databases)
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .sqlite)
    services.register(migrations)
    
//    let myService = NIOServerConfig.default(port: 8080)
//    services.register(myService)
}
