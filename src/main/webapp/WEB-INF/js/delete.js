$(function(){
	$('#deleteBtn').click(function(){
		$('#pwdDiv').empty();
		if($('#pwd').val()=='') {
			$('#pwdDiv').html('먼저 비밀번호를 입력');
			$('#pwdDiv').css('color','red');
		}
		else {
			$.ajax({
				type:'post',
				url: '/spring/user/getExistPwd',
				data: {id: $('#id').val()},  // 서버로 보내는 데이터
				dataType: 'json' , // 서버로부터 받는 데이터 타입
				success:function(data){
					if(data.pwd==$('#pwd').val()) {
						if(confirm('정말로 삭제하시겠습니까?')) {
							$.ajax({
								type:'post',
								url: '/spring/user/delete',
								data: {id: $('#id').val()},
								success: function(){
									alert('회원 삭제 완료');
									location.href='/spring/user/list';
								},
								error: function(e){
									console.log(e);
								}
							});
						}
					}
					else {
						$('#pwdDiv').html('비밀번호가 맞지 않습니다.');
					}
				},
				error:function(e){
					console.log(e);
				}
				
			});
		}
	});
	
});
