SELECT * FROM final.follow;
-- memberIdx : 팔로우를 누를 사람
-- memberIdx2 : 팔로우를 당한 사람
-- 팔로워: 해당 사용자를 팔로우 하는 사람 
-- 팔로잉: 해당 사용자가 팔로우 하는 사람

delete from final.follow where followIdx =1;

-- 1이 팔로우 하는 사람들 2,3,4,8,10 ->1의 팔로잉
select *
from final.follow
where memberIdx = 1;

-- 1을 팔로우 하는 사람들 2,3,4,5,6,7,8,9,10 (9명) ->1의 팔로워
select * 
from final.follow
where memberIdx2 =1
order by memberIdx;

-- 10이 팔로우하는 사람들 1,2,3,7,8 ->10의 팔로잉
select *
from final.follow
where memberIdx =10;

-- 1을 팔로우 하는 사람들(팔로워)중 10이 팔로우하는 사람들(팔로잉)과의 결과
-- 1) 2,3,7,8은 10이 이미 팔로우하는 중 -> 팔로우 그만하기로 표시
-- 2) 10은 본인 -> 버튼 보이지 않기
-- 3) 4,5,6,9 은 10이 팔로우하지 않는 중 -> 팔로우 시작하기로 표시
-- 1은 페이지 주인 -> 팔로우하는 중임(그렇지만 페이지 주인이기 때문에 팔로워, 팔로잉 리스트에 보이지 않음)


select F1.memberIdx as '남의 팔로워리스트',F2.memberIdx2 as '내가 팔로우하는지'
from (select * from final.follow where memberIdx2=1) as F1 left join (select * from final.follow where memberIdx=10) as F2
on   F1. memberIdx = F2.memberIdx2;


-- 남의 팔로워 리스트에서 내가 팔로우하는지 안하는지 결과 + member 정보까지 표현 (10월 8일)
select F1.memberIdx as yourFollowerIdx,
(select M.memberNickname from final.member as M where F1.memberIdx = M.memberIdx ) as memberNickname,
(select M.memberProfile from final.member as M where F1.memberIdx = M.memberIdx ) as memberProfile,
F2.memberIdx2 as followStatus
from (select * from final.follow where memberIdx2=1) as F1 left join (select * from final.follow where memberIdx=10) as F2 
on   F1. memberIdx = F2.memberIdx2
order by F1.memberIdx;

-- --------------------------------------------------------------------------------------------------------------------------------
-- 10월 9일 수정

-- 전체 사용자들의 follow정보
-- memberIdx : 팔로우 누른 사람 , memberIdx2 : 팔로우 당한 사람
-- follow table + member정보까지 같이 (memberIdx, meberIdx2의 프로필, 닉네임 모두 표현)
select F.memberIdx, M1.memberNickname, M1.memberProfile, F.memberIdx2, M2.memberNickname, M2.memberProfile
from final.follow as F inner join final.member as M1 inner join final.member as M2
on F.memberIdx = M1.memberIdx and F.memberIdx2 = M2.memberIdx
order by F.memberIdx;


-- view 로 만들기
create view followListView
as
select F.memberIdx, M1.memberNickname, M1.memberProfile, F.memberIdx2, M2.memberNickname as memberNickname2, M2.memberProfile as memberProfile2
from final.follow as F inner join final.member as M1 inner join final.member as M2
on F.memberIdx = M1.memberIdx and F.memberIdx2 = M2.memberIdx
order by F.memberIdx;

select * from followList;

select * from final.followlistview;

-- 남(idx = 1)의 follower중 내(idx =10)가 팔로우 하는지 안하는지 (null이면 팔로우 안하는 중)
select yours.memberIdx, mine.memberIdx2
from (select * from final.followListView where memberIdx2 =1) as yours left join (select * from final.followListView where memberIdx = 10) as mine
on  yours.memberIdx = mine.memberIdx2;

-- 필요한 정보모두 출력한 남의 follower 리스트 + 팔로우 버튼 상태(내 기준)
--     남의 팔로워 idx, 그 사람의 memberNickname, memberProfile,  내가 팔로우하는지 (안하면 null)
select yours.memberIdx, yours.memberNickname, yours.memberProfile, mine.memberIdx2 as followStatus
from (select * from final.followListView where memberIdx2 =1) as yours left join (select * from final.followListView where memberIdx = 10) as mine
on  yours.memberIdx = mine.memberIdx2
order by yours.memberIdx;


select * from final.member;

-- 남의 followingList + 버튼 상태
-- 남(idx=1)의 팔로잉 리스트에서 내(idx=10)가 팔로우 하는지 안하는 지 확인
--      남 idx,        남의 팔로잉 리스트 idx, 그 사람 닉네임          , 프로필 사진,           , 내가 팔로우하는지(null은 unfollow중)
select yours.memberIdx,yours.memberIdx2, yours.memberNickname2, yours.memberProfile2, mine.memberIdx2 as followStatus
from (select * from final.followlistView where memberIdx =1) as yours left join (select * from final.followListView where memberIdx = 10) as mine
on  yours.memberIdx2 = mine.memberIdx2
order by yours.memberIdx2;

select yours.memberIdx2, yours.memberNickname2, yours.memberProfile2, mine.memberIdx2 as followStatus
from (select * from final.followlistView where memberIdx =1) as yours left join (select * from final.followListView where memberIdx = 10) as mine
on  yours.memberIdx2 = mine.memberIdx2
order by yours.memberIdx2;


drop view final.followList;





