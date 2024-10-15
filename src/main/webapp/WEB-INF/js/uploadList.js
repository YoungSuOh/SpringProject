$(document).ready(function() {
    // 전체 선택 체크박스 클릭 시
    $('#all_check').click(function() {
        $('.board-list-check').prop('checked', this.checked); // 모든 체크박스 선택/해제
    });

    // 개별 체크박스 클릭 시 전체 선택 체크박스 상태 조정
    $('.board-list-check').click(function() {
        if ($('.board-list-check:checked').length === $('.board-list-check').length) {
            $('#all_check').prop('checked', true); // 모두 선택 시 전체 선택 체크
        } else {
            $('#all_check').prop('checked', false); // 하나라도 해제되면 전체 선택 해제
        }
    });

    // 선택 삭제 버튼 클릭 시
    $('#deleteBtn').click(function() {
        let selectedSeqs = [];
        
        // 선택된 항목의 시퀀스 번호 수집
        $('.board-list-check:checked').each(function() {
            selectedSeqs.push($(this).val());
        });

        if (selectedSeqs.length === 0) {
            alert('삭제할 항목을 선택하세요.');
            return;
        }

        // 서버로 선택된 시퀀스 목록 전송 (AJAX 사용 가능)
        $.ajax({
            url: '/spring/user/deleteSelected',
            type: 'POST',
            data: {
                seqs: selectedSeqs.join(',')
            },
            success: function(response) {
                alert('선택된 항목이 삭제되었습니다.');
                // 페이지 리로드 또는 다른 방식으로 목록 갱신
                location.reload();
            },
            error: function(err) {
                alert('삭제에 실패했습니다.');
            }
        });
    });
});