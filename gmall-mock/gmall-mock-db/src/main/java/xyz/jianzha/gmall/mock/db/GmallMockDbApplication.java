package xyz.jianzha.gmall.mock.db;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

/**
 * @author Y_Kevin
 * @date 2020-07-12 13:47
 */
@SpringBootApplication
@MapperScan("xyz.jianzha.gmall.mock.db.mapper")
public class GmallMockDbApplication {
    public static void main(String[] args) {
        ConfigurableApplicationContext context = SpringApplication.run(GmallMockDbApplication.class, args);

        MockTask mockTask = context.getBean(MockTask.class);

        mockTask.mainTask();
    }
}
