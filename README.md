# personal-project

### json을 활용한 비동기 방식의 게시판 리스트 페이지 구현을 작업하고 있습니다.
- 업로드 시점은 list 페이지가 어느정도 정상적으로 구동되는 시점입니다.
- 데이터 표현, 페이징, 데이터 갯수 변경, 검색 등의 기능이 올바르게 작동하는 것을 확인하였습니다.

### 비동기 방식을 구현하기 위에 활용한 언어는 jQuery 입니다.

### 추가적으로 진행중인 작업은 다음과 같습니다.
- 새로고침 등의 페이지 리로드가 진행되면 실제 페이지가 및 서버로의 데이터 전달이 이루어지지 않는 현상

		#### 작업 중에 문제가 발생하거나 막힌 부분 등에 대한 내역과 해결 사항을 적어보았습니다.
		#### (지속적으로 추가 할 예정입니다.)
		
		해결해야할 문제
		1. 페이지네이션의 링크를 클릭시 데이터는 페이지에 맞는 내용으로 변경되지만, 상단의 페이지 경로가 변경되지 않음.
			=> 변경은 가능하나 새로고침시 현재 상태가 유지되지 않음. 새로고침시에 변경된 정보들을 가지고 갈 수 있어야함

		추가해볼만한기능
		1. 검색기능 - (완료)
		2. 데이터 갯수 보기를 변경하는 기능(5개, 10개, 15개) - (완료)

		완료된 사항
		1. 전체 데이터는 138개이지만 현재 9페이지 (135개) 이후 10페이지에서 남는 데이터 3개를 확인할 수 없음.
			=> 해결. for문 내부에 if문을 활용하여 데이터가 null일 시 해당 for문을 종료되도록 해서 해결함.
				=> 참조. 이는 서버 데이터를 전달 받을 때 rowsPerPage를 활용하여 제한을 걸고 javascript 단에서 foreach로 배열을 전달받는 방식도 있다.
		2.(new) 데이터를 불러오는 것만 jquery로 처리하고 다른 기능은 java 및 서버쪽에서 처리 가능하도록 구조 변경
			=> BookRestController에서 List<Book>의 정보를 호출하는 것이 아니라 Map(String, Object)의 구조로 값을 전달받음
			=> 해당 구조로 변경하여 BookRestController에서 Pagination 정보를 가져올 수 있도록 기능 변경
			=> script에서 변경된 정보를 전달하여 restController에서 전달받아 정보를 변경해야하는데 이부분을 해결하지 못하고 있음
				데이터를 전달받을때마다 rest/bookList 경로가 변경되어야함
				ex) rest/bookList?page=2&opt=&value= 등의 구조로
			=> Criteria에서 Pagination정보를 불러와서 rest에서 criteria 및 pagination 정보를 한꺼번에 불러오도록 구조 변경
				=> 위 방식으로 변경하니 정상적으로 전달되는 값이 restController 값에 대입되어 변경된 값을 확인 가능하며 검색도 가능해짐
		3.(new) 페이지네이션 작동시 마지막 블록에서 표현되지 않아야할 블록이 나타나는 현상이 있음
			=> 해결 totalBlocks 의 계산식 오류가 있어 해당식을 수정
