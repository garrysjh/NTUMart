package com.ntumart.dipapp;

import java.io.File;
import java.sql.SQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.data.repository.init.Jackson2RepositoryPopulatorFactoryBean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.init.ScriptUtils;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class DipappApplication {

  @Autowired JdbcTemplate jdbcTemplate;

  public void executeSqlScript() {
    try {
      String sqlScriptPath = new File(System.getProperty("user.dir")).getParent() + "/DIPSHOP.sql";
      Resource resource = new FileSystemResource(sqlScriptPath);
      ScriptUtils.executeSqlScript(jdbcTemplate.getDataSource().getConnection(), resource);
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  public static void main(String[] args) {
    SpringApplication.run(DipappApplication.class, args);
  }

  @Bean
  public Jackson2RepositoryPopulatorFactoryBean getRespositoryPopulator() {
    executeSqlScript();
    Jackson2RepositoryPopulatorFactoryBean factory = new Jackson2RepositoryPopulatorFactoryBean();
    factory.setResources(new Resource[] {new ClassPathResource("data.json")});
    return factory;
  }
}
