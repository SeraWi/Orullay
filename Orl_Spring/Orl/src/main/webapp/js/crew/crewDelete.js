$(document).ready(function () {
    
    //크루 정보 가져옴
    $.ajax({
        url: url + '/crew/edit/getcrewinfo',
        type: 'get',
        data: {
            crewIdx: crewIdx,
            memberIdx: memberIdx
        },
        success: function (data) {
            if (!data.auth) {
                alert('해당 페이지에 접근 할 권한이 없습니다.');
                window.location.href = url2 + '/';
            }

            $('#crewname').html(data.info.crewName);
        },
        error: function(){
            alert('해당 페이지에 접근 할 권한이 없습니다.');
            window.location.href = url2 + '/';
        }
    });

    //서버에 제출
    $('#submit').on('click', function () {

        $.ajax({
            url: url + '/crew/remove/removecrew',
            type: 'post',
            data: {
                crewIdx: crewIdx,
                crewName: $('#crewNameRe').val(),
                memberIdx: memberIdx
            },
            success: function (data) {
                if (data.result != 0) {
                    alert('크루 삭제가 완료되었습니다.');
                    window.location.href = url2 + '/';
                } else {
                    alert('크루명이 일치하지 않습니다.');
                    history.go(-1);
                }
            },
            error: function(){
                alert('크루명이 일치하지 않습니다.');
            }
        });

    });
});

