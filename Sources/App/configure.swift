import Vapor
import FluentMySQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
   
    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    try services.register(FluentMySQLProvider())
    let mysqlConfig = MySQLDatabaseConfig(hostname: "127.0.0.1", port: 3306, username: "root", password: "910114", database: "mycooldb", transport: .unverifiedTLS)
    services.register(mysqlConfig)
    
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .mysql)
    services.register(migrations)
}
