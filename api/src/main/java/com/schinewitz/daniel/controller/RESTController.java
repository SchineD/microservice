package com.schinewitz.daniel.controller;

import com.schinewitz.daniel.config.AppInfoConfig;
import com.schinewitz.daniel.model.Post;
import com.schinewitz.daniel.repository.PostRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.Data;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@Log
@CrossOrigin("*")
@Tag(name = "posts", description = "Posts and stuff")
public class RESTController {

    @Autowired
    private AppInfoConfig appInfoConfig;

    @Autowired
    private PostRepository postRepository;

    @Data
    public class StringResponse {
        public String value;

        public StringResponse(String s) {
            this.value = s;
        }
    }

    @Operation(summary = "Version", description = "Tag or branch", tags = { "meta" })
    @GetMapping(value = "/version")
    public StringResponse getVersion() {
        return new StringResponse(appInfoConfig.getAppVersion());
    }


    @Operation(summary = "Get Posts", description = "Get all posts", tags = { "post" })
    @GetMapping(value = "/post/all")
    public List<Post> getPostList() {
        List<Post> postList = new ArrayList<>();
        postRepository.findAll().forEach(postList::add);

        return postList;
    }

    @Operation(summary = "Create Post", description = "Post a post", tags = { "post" })
    @PostMapping(value ="/post/create")
    public Post createtPost(@RequestBody Post post) {

        return postRepository.save(post);
    }
}