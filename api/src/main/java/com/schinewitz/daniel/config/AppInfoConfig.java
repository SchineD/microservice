package at.gv.wien.m01.pace.api.config;

import lombok.val;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.regex.Pattern;

@Configuration
public class AppInfoConfig {

    public static final String FILENAME = "/config/CURRENT_CONFIG_VERSION";
    public static final String ZONE_ID = "Europe/Vienna";
    public static final String SEMVER_REGEX = "^\\d+\\.\\d+\\.\\d+$";
    public static final String DEFAULT_VERSION = "UNDEFINED";

    @Bean
    @Scope("singleton")
    public AppInfoConfig getAppInfoConfig() {
        return new AppInfoConfig();
    }

    private static String knownVersion = null;

    public String getAppVersion() {
        if (knownVersion == null) {
            val f = new File(FILENAME);
            String version = DEFAULT_VERSION;
            if(f.isFile() && !f.isDirectory() && f.canRead()) {
                try {
                    version = new String(Files.readAllBytes(Paths.get(FILENAME)));
                    val pattern = Pattern.compile(SEMVER_REGEX);
                    val matcher = pattern.matcher(version);
                    if (!matcher.find()) {
                        val t_gmt = f.lastModified();
                        val timeStamp = LocalDateTime.ofInstant(Instant.ofEpochMilli(t_gmt), ZoneId.of(ZONE_ID));
                        version = String.format("%s (%s)", version, timeStamp);
                    }
                } catch (java.io.IOException ignored) {}
            }
            knownVersion = version;
        }
        return knownVersion;
    }
}
