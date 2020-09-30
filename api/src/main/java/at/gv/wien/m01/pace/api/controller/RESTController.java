package at.gv.wien.m01.pace.api.controller;

import at.gv.wien.m01.pace.api.model.cats.Cat;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Data;
import lombok.extern.java.Log;
import lombok.val;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;
import java.util.regex.Pattern;



@RestController
@Log
@Tag(name = "cats+", description = "Cats and more")
public class RESTController {

    @Data
    public class StringResponse {
        public String value;

        public StringResponse(String s) {
            this.value = s;
        }
    }

    private List<Cat> entityList = new ArrayList<>();

    {
        entityList.add(new Cat("Tonto", "A late cat", "tonto.jpg"));
        entityList.add(new Cat("Kazuuu!", "A black cat", "kazuuu.jpg"));
        entityList.add(new Cat("Gamer", "A cute cat", "gamer.jpg"));
    }

    @Operation(summary = "Zone", description = "DEV, CI_TEST, TEST or PROD, UNDEFINED otherwise", tags = { "meta" })
    @GetMapping(value = "/zone")
    public StringResponse getZone(@RequestHeader Map<String, String> headers) {
        if (headers.containsKey("x-portal-zone-status")) {
            return new StringResponse(headers.get("x-portal-zone-status"));
        }
        return new StringResponse("UNDEFINED");
    }

    @Operation(summary = "Version", description = "Tag or branch", tags = { "meta" })
    @GetMapping(value = "/version")
    public StringResponse getVersion() {
        val f = new File("/config/CURRENT_CONFIG_VERSION");
        String version = "UNDEFINED";
        if(f.isFile() && !f.isDirectory() && f.canRead()) {
            try {
                version = new String(Files.readAllBytes(Paths.get("/config/CURRENT_CONFIG_VERSION")));
                val pattern = Pattern.compile("^\\d+\\.\\d+\\.\\d+$");
                val matcher = pattern.matcher("foo");
                if (!matcher.find()) {
                    val t_gmt = f.lastModified();
                    val timeStamp = LocalDateTime.ofInstant(Instant.ofEpochMilli(t_gmt), ZoneId.of("Europe/Vienna"));
                    version = String.format("%s (%s)", version, timeStamp);
                }
            } catch (java.io.IOException e) {}
        }
        return new StringResponse(version);
    }

    @Operation(summary = "Portal headers", description = "list of portal headers received", tags = { "meta" })
    @GetMapping(value = "/whoami")
    public Map<String, String> whoAmI(@RequestHeader Map<String, String> headers) {
        return headers;
    }

    @Operation(summary = "List all cats", description = "all cats", tags = { "cat" })
    @GetMapping(value = "/cat/all")
    public List<Cat> findAll() {
        return entityList;
    }

    @Operation(summary = "Add a cat", description = "add a new cats", tags = { "cat" })
    @PostMapping(value = "/cat", consumes = { "application/json", "application/xml" })
    public Cat addCat(@RequestBody Cat cat) {
        cat.setId(UUID.randomUUID());
        entityList.add(cat);
        return cat;
    }

    @Operation(summary = "Get a cat", description = "get a cat by its id", tags = { "cat" })
    @GetMapping("/cat/findby/{id}")
    public Cat findById(@PathVariable UUID id) {
        return entityList.stream().
                filter(entity -> entity.getId().equals(id)).
                findFirst().orElse(null);
    }
}