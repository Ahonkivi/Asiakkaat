<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>

<table id="listaus">
	<thead>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>S�hk�posti</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>

<script>

$(document).ready(function(){
	$.ajax(
			{url:"asiakkaat",
				type:"GET",
				dataType:"json",
				success:function(result){
					$.each(result.asiakkaat, function(i, field){
						var htmlStr;
						htmlStr+="<tr>";
						htmlStr+="<td>"+field.etunimi+"</td>";
						htmlStr+="<td>"+field.sukunimi+"</td>";
						htmlStr+="<td>"+field.puhelin+"</td>";
						htmlStr+="<td>"+field.sposti+"</td>";
						htmlStr+="</tr>";
						$("#listaus tbody").append(htmlStr);
					});
					
	}
			});

});

</script>



</body>
</html>