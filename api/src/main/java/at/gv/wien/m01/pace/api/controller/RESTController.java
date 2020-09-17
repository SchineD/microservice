package at.gv.wien.m01.pace.api.controller;

import at.gv.wien.m01.pace.api.model.cats.Cat;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.java.Log;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@Log
@Tag(name = "cats+", description = "Cats and more")
public class RESTController {
    private List<Cat> entityList = new ArrayList<>();

    {
        entityList.add(new Cat("Tonto", "A late cat", "tonto.jpg"));
        entityList.add(new Cat("Kazuuu!", "A black cat", "kazuuu.jpg"));
        entityList.add(new Cat("Gamer", "A cute cat", "gamer.jpg"));
    }

    @Operation(summary = "Zone", description = "DEV, CI_TEST, TEST or PROD, UNDEFINED otherwise", tags = { "meta" })
    @GetMapping(value = "/zone")
    public String getZone() {
        String zone = System.getenv("ZONE");
        if (zone != null && !zone.isEmpty()) {
            return zone;
        }
        return "UNDEFINED";
    }

    @Operation(summary = "Version", description = "Tag or branch", tags = { "meta" })
    @GetMapping(value = "/version")
    public String getVersion() {
        return "master";
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