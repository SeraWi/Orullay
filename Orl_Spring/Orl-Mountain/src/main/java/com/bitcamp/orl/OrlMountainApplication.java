package com.bitcamp.orl;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.bitcamp.orl.mountain.mapper")
public class OrlMountainApplication {

	public static void main(String[] args) {
		SpringApplication.run(OrlMountainApplication.class, args);
	}

}
