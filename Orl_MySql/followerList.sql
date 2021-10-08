SELECT * FROM final.follow;
commit;

delete from final.follow where followIdx=67;


-- 1이 팔로우 하는 사람들 2,3,4,8,10
select *
from final.follow
where memberIdx = 1;

-- 1을 팔로우 하는 사람들 2,3,4,5,6,7,8,9,10 (9명)
select * 
from final.follow
where memberIdx2 =1
order by memberIdx;

-- 10이 팔로우하는 사람들 1,2,3,7,8
select *
from final.follow
where memberIdx =10;

-- 1을 팔로우 하는 사람들중 10이 팔로우하는 사람들과의 결과
-- 2,3,7,8은 10이 팔로우하는 중 -> 팔로우 그만하기로 표시
-- 10은 본인 -> 버튼 보이지 않기
-- 4,5,6,9 은 10이 팔로우하지 않는 중 -> 팔로우 시작하기로 표시
-- 1은 페이지 주인 -> 팔로우하는 중임


select F1.memberIdx as '남의 팔로워리스트',F2.memberIdx2 as '내가 팔로우하는지'
from (select * from final.follow where memberIdx2=1) as F1 left join (select * from final.follow where memberIdx=10) as F2
on   F1. memberIdx = F2.memberIdx2;



-- 남의 팔로워 리스트에서 내가 팔로우하는지 안하는지 결과 + member 정보까지 표현
select F1.memberIdx as yourFollowerIdx,
(select M.memberNickname from final.member as M where F1.memberIdx = M.memberIdx ) as memberNickname,
(select M.memberProfile from final.member as M where F1.memberIdx = M.memberIdx ) as memberProfile,
F2.memberIdx2 as followStatus
from (select * from final.follow where memberIdx2=7) as F1 left join (select * from final.follow where memberIdx=10) as F2 
on   F1. memberIdx = F2.memberIdx2
order by F1.memberIdx;



