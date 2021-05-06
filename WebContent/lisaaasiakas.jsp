<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<title>Lisää asiakas</title>
</head>
<body>

<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
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
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Lisää"></td>
			</tr>
		</tbody>
	</table>
</form>

<span id="ilmo"></span>
</body>

<script>

	$(document).ready(function(){
		$("#takaisin").click(function(){
			document.location="listaaasiakkaat.jsp";
		});


		$("#tiedot").validate({
			rules: {
				etunimi: {
					required: true,
					number: false
				},
				sukunimi: {
					required: true,
					number: false
				},
				puhelin: {
					required: true,
					number: true,
					minlength: 5,
					maxlength: 15
				},
				sposti: {
					required: true,
					email: true
				}
			},
			messages: {
				etunimi: {
					required: "Puuttuu",
					number: "Syötä vain kirjaimia"
				},
				sukunimi: {
					required: "Puuttuu",
					number: "Syötä vain kirjaimia"
				},
				puhelin: {
					required: "Puuttuu",
					number: "Syötä vain numeroita",
					minlength: "Liian lyhyt",
					maxlength: "Liian pitkä"
				},
				sposti: {
					required: "Puuttuu",
					email: "Ei ole kelvollinen sähköpostiosoite"
				}
			},
			submitHandler: function(form) {
				lisaaTiedot();			
				}
		});
		
	});

	function lisaaTiedot() {
		 var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
		
		$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", datatype:"json", success: function(result) {
			if(result.response == 0){
				$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
			} else if(result.response == 1) {
				$("#ilmo").html("Asiakkaan lisäminen onnistui.");
				$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
			}
		}
		});
	}
	

</script>


</html> 