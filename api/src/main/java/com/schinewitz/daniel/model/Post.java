package com.schinewitz.daniel.model.cats;

import lombok.Data;

import java.util.UUID;

@Data
public class Cat {
    private UUID id;
    private String name;
    private String description;
    private String imageName;

    public Cat(String name, String description, String imageName) {
        this.id = UUID.randomUUID();
        this.name = name;
        this.description = description;
        this.imageName = imageName;
    }
}
