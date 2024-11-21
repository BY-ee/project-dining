// 현재 경로 가져오기
     const currentPath = window.location.pathname;

     // 모든 버튼을 가져옴
     const tabs = document.querySelectorAll('.tab');

     // 각 버튼의 data-path와 현재 경로를 비교
     tabs.forEach(tab => {
         if (tab.dataset.path === currentPath) {
             tab.classList.add('active');
         }
     });