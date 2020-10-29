package view;

import config.ApplicationSetup;
import javafx.application.Application;
import javafx.stage.Stage;
import model.User;
import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.io.IoBuilder;

public class Main extends Application {

    // ApplicationSetup implements a singleton design pattern -> only one instance
    private static final ApplicationSetup applicationSetup = ApplicationSetup.getInstance();
    private static final Logger LOGGER = LogManager.getRootLogger();
    private static SceneManager sceneManager = null;
    private static Stage primaryStage = null;
    private static database.mysql.DBAccess dbAccessMySql;
    private static database.couchdb.DBAccess dbAccessCouchDb;

    private static User currentUser = null;

    public static void main(String[] args) {
        applicationSetup.load();
        setLogging();
        dbAccessMySql = getDBaccessMySql();
        dbAccessMySql.loadDriver();
        dbAccessCouchDb = getDbAccessCouchDb();
        getCouchDbConnection();
        launch(args);
    }

    public static void setLogging() {
        // Redirect System.err to logger
        System.setErr(
                IoBuilder.forLogger(LogManager.getLogger("system.err"))
                        .setLevel(Level.WARN)
                        .buildPrintStream()
        );
        // Redirect System.out to logger
        System.setOut(
                IoBuilder.forLogger(LogManager.getLogger("system.out"))
                        .setLevel(Level.INFO)
                        .buildPrintStream()
        );
    }

    public static void getCouchDbConnection() {
        try {
            dbAccessCouchDb.setupConnection();
            LOGGER.info("CouchDB connection open.");
        } catch (Exception connectionError) {
            LOGGER.error("CouchDB connection error: " + connectionError.getMessage());
        }
    }

    @Override
    public void start(Stage primaryStage) {
        Main.primaryStage = primaryStage;
        primaryStage.setTitle("Make IT Work - Project 1");
        getSceneManager().setWindowTool();
        primaryStage.show();
    }

    public static SceneManager getSceneManager() {
        if (sceneManager == null) {
            sceneManager = new SceneManager(primaryStage);
        }
        return sceneManager;
    }

    public static Stage getPrimaryStage() {
        return primaryStage;
    }

    public static User getCurrentUser() {
        return currentUser;
    }

    public static void setCurrentUser(User currentUser) {
        Main.currentUser = currentUser;
    }

    public static database.mysql.DBAccess getDBaccessMySql() {
        String dbName = applicationSetup.getProperties().getProperty("mysql.database.name");
        String dbUser = applicationSetup.getProperties().getProperty("msql.database.user");
        String dbPasword = applicationSetup.getProperties().getProperty("mysql.database.password");
        if (dbAccessMySql == null) {
            dbAccessMySql = new database.mysql.DBAccess(dbName, dbUser, dbPasword);
        }
        return dbAccessMySql;
    }

    public static database.couchdb.DBAccess getDbAccessCouchDb() {
        return new database.couchdb.DBAccess();
    }

}