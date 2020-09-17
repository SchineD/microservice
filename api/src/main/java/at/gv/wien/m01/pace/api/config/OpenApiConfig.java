package at.gv.wien.m01.pace.api.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class OpenApiConfig {

    @Value("${portal.application.name}")
    private String portalApplicationName;

    @Bean
    public OpenAPI customOpenAPI() {

        List<Server> servers = new ArrayList<>();
        servers.add(new Server().description("base URL").url("/"+portalApplicationName+"/api/"));

        return new OpenAPI()
                .components(new Components())
                .info(new Info().title("Springboot React Starter API").description(
                        "This is a sample service using springdoc-openapi-ui and OpenAPI 3."))
                .servers(servers);
    }
}