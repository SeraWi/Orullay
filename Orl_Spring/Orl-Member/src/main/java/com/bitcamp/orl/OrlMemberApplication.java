package com.bitcamp.orl;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.bitcamp.orl.member.dao")
@SpringBootApplication
public class OrlMemberApplication {

	public static void main(String[] args) {
		SpringApplication.run(OrlMemberApplication.class, args);
	}

}
