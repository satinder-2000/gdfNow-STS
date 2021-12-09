package org.gdf.config;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.session.jdbc.config.annotation.SpringSessionDataSource;
import org.springframework.session.jdbc.config.annotation.web.http.EnableJdbcHttpSession;

//@EnableJdbcHttpSession
//@Configuration
public class DataAccessConfiguration {
	
	@Value("${spring.datasource.driver-class-name}")
	private String dbJdbcDriver;
	
	@Value("${db.session.conn.string}")
	private String dbSesnConnString;
	   
	@Value("${db.session.access.username}")
	private String dbSesnAccessUserName;

	@Value("${db.session.access.password}")
	private String dbSesnAccessPassword;

	@Value("${db.session.access.validity.query}")
	private String dbSesnAccessValityQuery;
	
	//@SpringSessionDataSource
	//@Bean
	public DataSource sessionDataSource() {
		BasicDataSource dataSource = new BasicDataSource();
		dataSource.setDriverClassName(dbJdbcDriver);
	    dataSource.setUrl(dbSesnConnString);
	    dataSource.setUsername(dbSesnAccessUserName);
	    dataSource.setPassword(dbSesnAccessPassword);
	    dataSource.setMaxIdle(4);
	    dataSource.setMaxTotal(20);
	    dataSource.setInitialSize(4);
	    dataSource.setMaxWaitMillis(900000);
	    dataSource.setTestOnBorrow(true);
	    dataSource.setValidationQuery(dbSesnAccessValityQuery);
	      
	    return dataSource;
	}
	
}
