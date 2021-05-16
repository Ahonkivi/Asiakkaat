<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="scripts/main.js"></script>
<title>Lisää asiakas</title>
</head>
<body onkeydown="tutkiKey(event)">

<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="3" id="ilmo"></th>
				<th colspan="5" class="oikealle"><a href="listaaasiakkaat.jsp" id="takaisin">Takaisin listaukseen</a></th>
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
				<td><input type="button" name="nappi" id="tallenna" value="Lisää" onclick="lisaaTiedot()"></td>
			</tr>
		</tbody>
	</table>
</form>

<span id="ilmo"></span>
</body>

<script>

function tutkiKey(event){
	if(event.keyCode==13){//Enter
		lisaaTiedot();
	}
	
};

document.getElementById("asiakas_id").focus();
/*
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
*/
/*
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
	*/
	function lisaaTiedot() {	
		var ilmo="";
		if(document.getElementById("etunimi").value.length<1){
			ilmo="Etunimi ei kelpaa!";		
		}else if(document.getElementById("sukunimi").value.length<1){
			ilmo="Sukunimi ei kelpaa!";		
		}else if(document.getElementById("puhelin").value.length<5){
			ilmo="Puhelinnumero ei kelpaa!";		
		}else if(document.getElementById("sposti").value.length<5){
			ilmo="Sähköposti ei ole kelpaa!";			
		}
		if(ilmo!=""){
			document.getElementById("ilmo").innerHTML=ilmo;
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 3000);
			return;
		}
		document.getElementById("etunimi").value=siivoa(document.getElementById("etunimi").value);
		document.getElementById("sukunimi").value=siivoa(document.getElementById("sukunimi").value);
		document.getElementById("puhelin").value=siivoa(document.getElementById("puhelin").value);
		document.getElementById("sposti").value=siivoa(document.getElementById("sposti").value);	
			
		var formJsonStr=formDataToJSON(document.getElementById("tiedot")); //muutetaan lomakkeen tiedot json-stringiksi
		//L�het��n uudet tiedot backendiin
		fetch("asiakkaat",{//L�hetet��n kutsu backendiin
		      method: 'POST',
		      body:formJsonStr
		    })
		.then( function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi		
			return response.json()
		})
		.then( function (responseJson) {//Otetaan vastaan objekti responseJson-parametriss�	
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Asiakkaan lisääminen epäonnistui";
	      	}else if(vastaus==1){	        	
	      		document.getElementById("ilmo").innerHTML= "Asiakkaan lisääminen onnistui";			      	
			}
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		});	
		document.getElementById("tiedot").reset(); //tyhjennet��n tiedot -lomake
	}

</script>

</html> 