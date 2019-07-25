<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
	function readResponse() {
		var obj = new XMLHttpRequest();
		
		obj.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {

				var res = this.responseText;
				document.getElementById("demo").innerHTML = res;
			}
		};
		obj.open("GET", "demo2.jsp", true);
		obj.send();
	}
</script>
</head>
<body>
	<h1 onclick="readResponse()">Call Ajax</h1>
	<h2 style="color: red" id="demo"></h2>
</body>
</html>






