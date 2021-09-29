package com.bitcamp.orl.crew.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CrewListCriteria {
	
	private int page; // 보여줄 페이지
    private int perPageNum = 6; // 페이지당 보여줄 페이지수
 
    public CrewListCriteria() {
    	this.page = 1;
    }
    
    public CrewListCriteria(int page){
        this.page = page;
    }
    
    public int getPageStart(){
        return (this.page -1) * this.perPageNum;
    }
 
    public void setPage(int page) {
        if ( page <= 0 ){
            this.page = 1;
        }else{
            this.page = page;
        }
    }
    
    public int getPerPageNum() {
    	return perPageNum;
    }
     
}
