$(function(){
    $('#updateImageBtn').click(function(){
        let formData = new FormData($('#uploadUpdateForm')[0]);  // 'formData'로 변수명 통일
        $.ajax({
            type: 'post',
            enctype: 'multipart/form-data',
            url: '/spring/user/uploadUpdate',
            contentType: false,
            processData: false,
            data: formData,  // 변수명 일치
            success: function(data){
                alert(data);
                location.href = '/spring/user/uploadList';
            },
            error: function(e){
                console.log(e);
            }
        });
    });
});
