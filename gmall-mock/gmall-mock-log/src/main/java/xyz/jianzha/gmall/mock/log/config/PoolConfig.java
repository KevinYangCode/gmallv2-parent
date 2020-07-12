package xyz.jianzha.gmall.mock.log.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

/**
 * @author Y_Kevin
 * @date 2020-07-12 16:15
 */
@Configuration
public class PoolConfig {

    @Bean
    public ThreadPoolTaskExecutor getPoolExecutor() {

        ThreadPoolTaskExecutor threadPoolTaskExecutor = new ThreadPoolTaskExecutor();
        //线程数
        threadPoolTaskExecutor.setCorePoolSize(8);
        //等待队列容量 ，线程数不够任务会等待
        threadPoolTaskExecutor.setQueueCapacity(1000);
        // 最大线程数，等待数不够会增加线程数，直到达此上线  超过这个范围会抛异常
        threadPoolTaskExecutor.setMaxPoolSize(12);
        threadPoolTaskExecutor.initialize();

        return threadPoolTaskExecutor;
    }
}
