package com.bitcamp.orl.feed.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bitcamp.orl.feed.service.LikeService;

@RestController
public class FeedLikeController {
   
   @Autowired
   private LikeService likeService;
   
   //비동기통신으로 좋아요 누르고 취소하기 처리
   @PostMapping("/feed/likeButtonClick")
   @CrossOrigin
   public int insertLike(
         @RequestParam("boardIdx") int boardIdx,
         @RequestParam("likeChange") int likeChange,
         @RequestParam("myIdx") int myIdx
         ) {
      
      
      int likeResult =0;
      
      if(likeChange==1) {
         
         likeResult = likeService.insertLike(myIdx,boardIdx);
         
      }else {
         
         likeResult = likeService.deleteLike(myIdx,boardIdx);
      }
      
      System.out.println("boot like");
      return likeResult;
   }
   
   
}