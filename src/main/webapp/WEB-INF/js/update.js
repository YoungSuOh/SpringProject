$(function(){ 

    $('#updateBtn').click(function(){
        $('#nameDiv').empty();
        $('#pwdDiv').empty();
        
        let name = $('#name').val();
        let pwd = $('#pwd').val();
        
        console.log(name+" "+id+" "+pwd);
        
        if(name == ''){
            $('#nameDiv').html('이름을 입력하세요');
        } else if(pwd == ''){
            $('#pwdDiv').html('비밀번호를 입력하세요');
        } else {
            $.ajax({
                type: 'post',
                url: '/spring/user/update',
                data: $('#userUpdateForm').serialize(), 
                success: function(data){                	
                    alert('변경 완료');
                    location.href='/spring/user/list?pg='+$('#pg').val();
                },
                error: function(e){
                    console.log(e);
                }
            });
        }
    });
});
