<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Muuta asiakastiedot</title>
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
				<th>S�hk�posti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td>
				<td><input type="submit" id="tallenna" value="Hyv�ksy"></td>
			</tr>
		</tbody>
	</table>
 	<input type="hidden" name="asiakas_id" id="asiakas_id"> 
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	//Haetaan muutettavan auton tiedot. Kutsutaan backin GET-metodia ja v�litet��n kutsun mukana muutettavan tiedon id
	//GET /autot/haeyksi/rekno
	var asiakas_id = requestURLParam("asiakas_id"); //Funktio l�ytyy scripts/main.js
	console.log("asiakas_id formissa", asiakas_id);
	$.ajax({url:"asiakkaat/haeyksi/"+asiakas_id, type:"GET", dataType:"json", success:function(result){	
		$("#asiakas_id").val(asiakas_id);		
		$("#etunimi").val(result.etunimi);	
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);			
    }});
	
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
				number: "Sy�t� vain kirjaimia"
			},
			sukunimi: {
				required: "Puuttuu",
				number: "Sy�t� vain kirjaimia"
			},
			puhelin: {
				required: "Puuttuu",
				number: "Sy�t� vain numeroita",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitk�"
			},
			sposti: {
				required: "Puuttuu",
				email: "Ei ole kelvollinen s�hk�postiosoite"
			}
		},
		submitHandler: function(form) {	
			paivitaTiedot();
		}		
	}); 	
});
//funktio tietojen p�ivitt�mist� varten. Kutsutaan backin PUT-metodia ja v�litet��n kutsun mukana uudet tiedot json-stringin�.
//PUT /autot/
function paivitaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	console.log("Hello i am paivitatiedot() formdata will be printed", formJsonStr)
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan p�ivitt�minen ep�onnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan p�ivitt�minen onnistui.");
      	$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
	  }
  }});	
}
</script>
</html>