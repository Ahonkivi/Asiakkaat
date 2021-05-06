<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
<style>
.oikealle {
	text-align;
}
</style>
</head>
<body>

<table id="listaus">
	<thead>
		<tr  class="oikealle"> 
			<th colspan= "5"><span id="uusiAsiakas"> Lisää uusi asiakas</span></th>
		</tr>	
		<tr>
			<th class="oikealle">Hakusana:</th>
			<th colspan="3"><input type="text" id="hakusana"></th>
			<th><input type="button" value="Hae" id="hakunappi"></th>
		</tr>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>

<script>

$(document).ready(function(){
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
	haeAsiakkaat();
	$("#hakunappi").click(function(){
		haeAsiakkaat();
	});

});

function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax(
			{url:"asiakkaat/"+$("#hakusana").val(),
				type:"GET",
				dataType:"json",
				success:function(result){
					$.each(result.asiakkaat, function(i, field){
						var htmlStr;
						htmlStr+="<tr>";
						htmlStr+="<td>"+field.etunimi+"</td>";
						htmlStr+="<td>"+field.sukunimi+"</td>";
						htmlStr+="<td>"+field.puhelin+"</td>"
						htmlStr+="<td>"+field.sposti+"</td>";
						htmlStr+="<td><span class='poista' onclick=poista('"+field.asiakas_id+"')>Poista</span></td>";
						htmlStr+="</tr>";
						$("#listaus tbody").append(htmlStr);
					});
					
		}});
}
	function poista(asiakas_id){
		console.log(asiakas_id);
		if(confirm("Poista asiakas " + asiakas_id +"?")){
			$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
		        if(result.response==0){
		        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
		        }else if(result.response==1){
		        	$("#rivi_"+asiakas_id).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
		        	alert("Asiakkaan " + asiakas_id +" poisto onnistui.");
					haeAsiakkaat();        	
				}
		    }});
		}
	}


</script>



</body>
</html>