$(function(){
    $('#id').focusout(function(){
        $('#idDiv').empty();
        
        if($('#id').val() == '') {
            $('#idDiv').html('먼저 아이디 입력');
        } else {
            $.ajax({
                type: 'post',
                url: '/spring/user/getExistId',
                data: { id: $('#id').val() },  // 객체로 전달
                datatype: 'text',
                success: function(data){
                    if(data == 'exist'){
                        $('#idDiv').css('color', 'red');
                        $('#idDiv').html('사용 불가능');
                    } else {
                        $('#idDiv').css('color', 'blue');
                        $('#idDiv').html('사용 가능');
                    }
                },
                error: function(e){
                    console.log(e);
                }
            });
        }
    });

    $('#writeBtn').click(function(){
        $('#nameDiv').empty();
        $('#idDiv').empty();
        $('#pwdDiv').empty();
        
        let name = $('#name').val();
        let id = $('#id').val();
        let pwd = $('#pwd').val();
        
        console.log(name+" "+id+" "+pwd);
        
        if(name == ''){
            $('#nameDiv').html('이름을 입력하세요');
        } else if(id == ''){
            $('#idDiv').html('아이디를 입력하세요');
        } else if(pwd == ''){
            $('#pwdDiv').html('비밀번호를 입력하세요');
        } else {
            $.ajax({
                type: 'post',
                url: '/spring/user/write',
                data: $('#memberWriteForm').serialize(), 
                success: function(){                	
                    alert('가입 완료');
                    location.href='/spring/user/list';
                },
                error: function(e){
                    console.log(e);
                }
            });
        }
    });
});
