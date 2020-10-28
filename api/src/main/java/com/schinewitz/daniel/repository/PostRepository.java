package com.schinewitz.daniel.repository;

import com.schinewitz.daniel.model.Post;
import org.springframework.data.repository.CrudRepository;

public interface PostRepository extends CrudRepository<Post, Long> {
}
