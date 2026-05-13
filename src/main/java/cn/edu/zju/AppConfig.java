package cn.edu.zju;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class AppConfig {

    private static final Logger log = LoggerFactory.getLogger(AppConfig.class);
    private static final AppConfig instance = new AppConfig();

    public static AppConfig getInstance() {
        return instance;
    }

    public AppConfig() {
        Properties properties = loadMergedProperties();
        this.jdbcUrl = properties.getProperty("jdbc.url");
        this.jdbcUsername = properties.getProperty("jdbc.username");
        this.jdbcPassword = properties.getProperty("jdbc.password");
    }

    private static Properties loadMergedProperties() {
        Properties properties = new Properties();
        ClassLoader loader = Thread.currentThread().getContextClassLoader();
        loadResource(loader, properties, "app.properties");
        loadResource(loader, properties, "app.local.properties");
        overrideFromEnv(properties);
        return properties;
    }

    private static void loadResource(ClassLoader loader, Properties properties, String name) {
        try (InputStream in = loader.getResourceAsStream(name)) {
            if (in != null) {
                properties.load(in);
            }
        } catch (IOException e) {
            log.warn("Failed to load {}", name, e);
        }
    }

    private static void overrideFromEnv(Properties properties) {
        String url = System.getenv("JDBC_URL");
        if (url != null && !url.isBlank()) {
            properties.setProperty("jdbc.url", url);
        }
        String user = System.getenv("JDBC_USERNAME");
        if (user != null && !user.isBlank()) {
            properties.setProperty("jdbc.username", user);
        }
        String password = System.getenv("JDBC_PASSWORD");
        if (password != null && !password.isBlank()) {
            properties.setProperty("jdbc.password", password);
        }
    }

    private String jdbcUrl;
    private String jdbcUsername;
    private String jdbcPassword;

    public String getJdbcUrl() {
        return jdbcUrl;
    }

    public void setJdbcUrl(String jdbcUrl) {
        this.jdbcUrl = jdbcUrl;
    }

    public String getJdbcUsername() {
        return jdbcUsername;
    }

    public void setJdbcUsername(String jdbcUsername) {
        this.jdbcUsername = jdbcUsername;
    }

    public String getJdbcPassword() {
        return jdbcPassword;
    }

    public void setJdbcPassword(String jdbcPassword) {
        this.jdbcPassword = jdbcPassword;
    }
}
