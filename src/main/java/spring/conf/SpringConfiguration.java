// Chapter05_ANNO/src/main/java/spring/conf/SpringConfiguration.java
package spring.conf;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement // <tx:annotation-driven transaction-manager="transactionManager"/> 대신 사용
@PropertySource("classpath:spring/db.properties")
@MapperScan("com.user.dao")
public class SpringConfiguration { // Connection Pool & DataSource
   
   @Value("${jdbc.driver}")
   private String driver;
   
   @Value("${jdbc.url}")
   private String url;
   
   @Value("${jdbc.username}")
   private String username;
   
   @Value("${jdbc.password}")
   private String password;
   // ============
   @Autowired
   private ApplicationContext applicationContext;
   

   // Chapter05_XML/src/spring/applicationContext.xml line 14 - 20
   @Bean
   public BasicDataSource dataSource() {
      BasicDataSource basicDataSource = new BasicDataSource();
      basicDataSource.setDriverClassName(driver);
      basicDataSource.setUrl(url);
      basicDataSource.setUsername(username);
      basicDataSource.setPassword(password);
      
      return basicDataSource;
   }
   
   // Chapter05_XML/src/spring/applicationContext.xml line 22 - 27
   @Bean
   public SqlSessionFactory sqlSessionFactory() throws Exception {
      SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
      sqlSessionFactoryBean.setDataSource(dataSource());
      //sqlSessionFactoryBean.setConfigLocation(new ClassPathResource("spring/mybatis-config.xml"));
      sqlSessionFactoryBean.setTypeAliasesPackage("com.user.bean");  // 
      
      
      // mapper가 1개인 경우(Mapper.xml)
      //sqlSessionFactoryBean.setMapperLocations(new ClassPathResource("mapper/userMapper.xml"));      
      
      /*
      // mapper가 여러 개인 경우
      sqlSessionFactoryBean.setMapperLocations(
    		  new ClassPathResource("mapper/userMapper.xml"),
    		  new ClassPathResource("mapper/userUploadMapper.xml")
    		  );
    		  */
      sqlSessionFactoryBean.setMapperLocations(
    		  applicationContext.getResources("classpath:mapper/*Mapper.xml")
    		  );
      
      return sqlSessionFactoryBean.getObject(); // SqlSessionFactory 로 변환하여 넘겨줌
   }
   
   // Chapter05_XML/src/spring/applicationContext.xml line 29 - 32
   @Bean
   public SqlSessionTemplate sqlSession() throws Exception {
      SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory());
      
      return sqlSessionTemplate;
   }
   
   // Chapter05_XML/src/spring/applicationContext.xml line 34 - 37   
   @Bean
   public DataSourceTransactionManager transactionManager() {
      DataSourceTransactionManager dataSourceTransactionManager = 
            new DataSourceTransactionManager(dataSource());
      
      return dataSourceTransactionManager;
   }
   
}
