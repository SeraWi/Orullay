-- 저장 프로시저로 발전시키기 1102

-- 기존 (view 사용해서 처리)
-- 남의 follower 리스트에서 내가 팔로우 하는지
select yours.memberIdx, yours.memberNickname, yours.memberProfile, mine.memberIdx2 as followStatus
from (select * from final.followListView where memberIdx2 =1) as yours left join (select * from final.followListView where memberIdx = 10) as mine
on  yours.memberIdx = mine.memberIdx2
order by yours.memberIdx;

-- 남의 팔로잉리스트에서 내가 팔로우하는지
select yours.memberIdx2, yours.memberNickname2, yours.memberProfile2, mine.memberIdx2 as followStatus
from (select * from final.followlistView where memberIdx =1) as yours left join (select * from final.followListView where memberIdx = 10) as mine
on  yours.memberIdx2 = mine.memberIdx2
order by yours.memberIdx2;


-- 프로시저 생성 (매개변수 in yourIdx 와 myIdx)
delimiter //
create procedure getFollower(
 in yourIdx int,
 in myIdx int
)
begin
	select yours.memberIdx, yours.memberNickname, yours.memberProfile, mine.memberIdx2 as followStatus
	from (select * from final.followListView where memberIdx2 = yourIdx) as yours 
    left join (select * from final.followListView where memberIdx = myIdx) as mine
	on  yours.memberIdx = mine.memberIdx2
	order by yours.memberIdx;
end //
delimiter ;

-- 프로시져 호출
call getFollower(1,10);

-- following 프로시져 생성
delimiter //
create procedure getFollowing(
 in yourIdx int,
 in myIdx int
)
begin
select yours.memberIdx2, yours.memberNickname2, yours.memberProfile2, mine.memberIdx2 as followStatus
from (select * from final.followlistView where memberIdx =yourIdx) as yours left join (select * from final.followListView where memberIdx = myIdx) as mine
on  yours.memberIdx2 = mine.memberIdx2
order by yours.memberIdx2;
end //
delimiter ;


call getFollowing(1,10);
